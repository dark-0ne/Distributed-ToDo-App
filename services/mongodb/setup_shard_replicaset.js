conn = new Mongo("localhost:16969");

rs.initiate({
  _id: process.env.REPL_SET_NAME,
  members: [
    { _id: 0, host: process.env.REPL_SET_NAME + "-0:16969" },
    { _id: 1, host: process.env.REPL_SET_NAME + "-1:16969" },
    { _id: 2, host: process.env.REPL_SET_NAME + "-2:16969" },
  ],
});
