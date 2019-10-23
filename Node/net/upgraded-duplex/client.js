const net = require('net');
const { ids } = require('../config');

const client = new net.Socket();

client.on('data', buf => {
  
});

client.connect({
  host: '127.0.0.1',
  port: 3000
});

client.write(Buffer.from('hello'));