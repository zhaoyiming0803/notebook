const net = require('net');
const { userMap } = require('../config');

const server = net.createServer(socket => {
  socket.on('data', buf => {
    
  });
});

server.listen(3000);