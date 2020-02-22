# Database migration steps

1. Prepare SQLite .db file with schema and data you want to migrate.
2. Go to `src/notejam/` directory and find `migrate.sh` script.
3. Run script using command:

> ./migrate.sh notejam.db

Where notejam.db is a path to the prepared .db file from step 1.

4. You will get `sqlite_dump_data.sql` file with SQL commands to run in your database. Go to `pgAdmin4` or similiar software and run migrations script.