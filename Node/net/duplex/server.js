const net = require('net');
const { userMap } = require('../config');
const server = net.createServer(socket => {
  socket.on('data', buf => {
    setTimeout(() => {
      const seq = buf.slice(0, 2);
      const id = buf.readInt16BE(2);
      socket.write(Buffer.concat([seq, Buffer.from(userMap[id])]));
    }, Math.random() * 500);
  });
});

server.listen(3000);