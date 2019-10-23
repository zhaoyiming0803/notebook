const net = require('net');
const { userMap } = require('../config');
const server = net.createServer(socket => {
  socket.on('data', buf => {
    setTimeout(() => {
      socket.write(Buffer.from(userMap[buf.toString()]));
    }, 1e3);
  });

  socket.on('end', e => {
    console.log('end', e);
  });

  socket.on('error', e => {
    console.log('error', e);
  });
});

server.listen(3000);