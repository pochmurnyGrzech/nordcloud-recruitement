var settings = {
  development: {
    db: process.env.DB_NAME,
    dsn: process.env.CONNECTION_STRING
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
