const net = require('net');
const client = new net.Socket();
const { ids } = require('../config');

client.connect({
  host: '127.0.0.1',
  port: 3000,
});

let seq = 0;

client.on('data', buf => {
  const seq = buf.slice(0, 2);
  console.log(seq.readInt16BE());

  const uname = buf.slice(2);
  console.log(uname.toString());

  console.log('------');
});

setInterval(() => {
  const index = Math.floor(Math.random() * ids.length);
  const buf = Buffer.alloc(4);
  buf.writeInt16BE(seq++, 0);
  buf.writeInt16BE(ids[index], 2);
  client.write(buf);
  console.log('id: ', ids[index]);
}, 500);
