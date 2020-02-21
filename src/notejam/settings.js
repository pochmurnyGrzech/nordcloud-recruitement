var settings = {
  development: {
    db: "psqldb0notejam0lab0we",
    dsn: "postgres://psqladminum@psql0notejam0lab0we:zaq1@WSX@psql0notejam0lab0we.postgres.database.azure.com/psqldb0notejam0lab0we?ssl=true",
  },
  test: {
    db: "notejam_test.db",
    dsn: "sqlite://notejam_test.db"
  }
};


var env = process.env.NODE_ENV
if (!env) {
  env = 'development'
};
module.exports = settings[env];
