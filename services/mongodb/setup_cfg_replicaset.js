conn = new Mongo("localhost:18585");

rs.initiate({
  _id: "cfg",
  members: [
    { _id: 0, host: "mongodb-cfgsrv-0:18585" },
    { _id: 1, host: "mongodb-cfgsrv-1:18585" },
    { _id: 2, host: "mongodb-cfgsrv-2:18585" },
  ],
});
