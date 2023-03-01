conn = new Mongo("localhost:16969");

rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-0:16969" },
    { _id: 1, host: "mongodb-1:16969" },
    { _id: 2, host: "mongodb-2:16969" },
  ],
});
