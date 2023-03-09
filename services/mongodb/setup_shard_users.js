conn = new Mongo("localhost:16969");

db = conn.getDB("admin");
db.createUser({
  user: "dark0ne",
  pwd: process.env.MONGODB_ADMIN_PWD,
  roles: ["root"],
});
