const net = require('net');
const { ids } = require('../config');
const client = new net.Socket();

client.connect({
  host: '127.0.0.1',
  port: 3000
});

function send () {
  const index = Math.floor((Math.random() * ids.length));
  client.write(Buffer.from(ids[index]));
}

client.on('data', buf => {
  console.log(buf, buf.toString());
  send();
});

client.on('end', e => {
  console.log('end', e);
});

client.on('error', e => {
  console.log('error', e);
});

send();
