conn = new Mongo(
  "mongodb://dark0ne:" + process.env.MONGODB_ADMIN_PWD + "@localhost:16985"
);

db = conn.getDB("admin");

sh.addShard(
  "mongodb-shard0/mongodb-shard0-0:16969,mongodb-shard0-1:16969,mongodb-shard0-2:16969"
);

sh.addShard(
  "mongodb-shard1/mongodb-shard1-0:16969,mongodb-shard1-1:16969,mongodb-shard1-2:16969"
);

sh.addShard(
  "mongodb-shard2/mongodb-shard2-0:16969,mongodb-shard2-1:16969,mongodb-shard2-2:16969"
);

sh.shardCollection("todo-app.users", { _id: 1 }, true);
