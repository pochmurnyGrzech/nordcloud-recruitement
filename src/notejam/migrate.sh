#!/bin/bash

# This script will migrate schema and data from a SQLite3 database to PostgreSQL.
# Schema translation based on http://stackoverflow.com/a/4581921/1303625.
# Some column types are not handled (e.g blobs).
# 
# See also:
# - http://stackoverflow.com/questions/4581727/convert-sqlite-sql-dump-file-to-postgresql
# - https://gist.github.com/bittner/7368128

# cross-OS compatibility (greadlink, gsed, gzcat are GNU implementations for OSX)
readlink=readlink; sed=sed; zcat=zcat
[[ `uname` == 'Darwin' ]] && {
	readlink=greadlink; sed=gsed; zcat=gzcat
		which $readlink $sed $zcat > /dev/null || {
		echo 'ERROR: GNU utils required for Mac. You may use homebrew to install them: brew install coreutils gnu-sed'
		exit 1
	}
}

SQLITE_DB_PATH=$1

SQLITE_DUMP_FILE="sqlite_dump_data.sql"

sqlite3 $SQLITE_DB_PATH .dump > $SQLITE_DUMP_FILE

# PRAGMAs are specific to SQLite3.
$sed -i '/PRAGMA/d' $SQLITE_DUMP_FILE
# Remove unsigned as Postgres doesn't know it.
$sed -i 's/ unsigned[ ]*/ /g' $SQLITE_DUMP_FILE
# Convert sequences.
$sed -i '/sqlite_sequence/d ; s/integer PRIMARY KEY AUTOINCREMENT/serial PRIMARY KEY/ig ; s/"id" integer NOT NULL PRIMARY KEY/"id" serial NOT NULL PRIMARY KEY/g' $SQLITE_DUMP_FILE
# Convert column types.
$sed -i 's/datetime/timestamp with time zone/g ; s/integer[(][^)]*[)]/integer/g ; s/text[(]\([^)]*\)[)]/varchar(\1)/g' $SQLITE_DUMP_FILE
# Convert 0/1 values for boolean types to '0'/'1'.
for bool in 0 0 1 1; do
	# global flag seems to be broken(?) for -i on OSX GNU sed, so we loop twice
	$sed -i "s/,${bool},/,'${bool}',/g" $SQLITE_DUMP_FILE
	$sed -i "s/,${bool})/,'${bool}')/g" $SQLITE_DUMP_FILE
	$sed -i "s/(${bool},/('${bool}',/g" $SQLITE_DUMP_FILE
done

$sed -i 's/created_at/created_at timestamp/g' $SQLITE_DUMP_FILE
$sed -i 's/updated_at/updated_at timestamp/g' $SQLITE_DUMP_FILE
