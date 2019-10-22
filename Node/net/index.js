const net = require('net');

; (function () {
  
  const socket = new net.Socket();

  socket.connect({
    host: '127.0.0.1',
    port: 4000
  });

  socket.on('data', buf => {
    console.log(buf.toString());
  });

  socket.on('close', () => {
    console.log('close');
  });

  socket.on('lookup', (error, address, host, family) => {
    console.log('error: ', error);
    console.log('address: ', address);
    console.log('host: ', host);
    console.log('family: ', family);
  });

  socket.on('error', error => {
    console.log('error');
  });

  socket.write(Buffer.from('hello server'));
})();

; (function () {

  const server = net.createServer(socket => {
    socket.on('data', buf => {
      console.log(buf.toString());
      socket.write(Buffer.from('hello client'));
    });
  });

  server.listen(4000);

})();