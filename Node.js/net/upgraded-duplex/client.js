const net = require('net');
const { ids } = require('../config');

const client = new net.Socket();
let remnat = null;

client.on('data', buf => {
  // console.log(buf.readInt16BE(0));
  // console.log(buf.readInt32BE(2));
  // console.log(buf.readInt32BE(6));
  if (remnat) {
    buf = Buffer.concat([remnat, buf]);
  }

  let packageLength = 0;

  while (packageLength = isComplete(buf)) {
    const package = buf.slice(0, packageLength);
    buf = buf.slice(packageLength);
    remnat = null;
    const content = decode(package);
    console.log(content);
  }

  remnat = buf;
});

client.connect({
  host: '127.0.0.1',
  port: 3000
});

let seq = 0;

function encode (id) {
  const body = Buffer.alloc(4);
  body.writeInt32BE(id);

  const header = Buffer.alloc(6);
  header.writeInt16BE(seq++);
  header.writeInt32BE(body.length, 2);

  return Buffer.concat([header, body]);
}

function decode (buf) {
  const header = buf.slice(0, 6);
  const body = buf.slice(6);
  return {
    seq: header.readInt16BE(),
    bodyLength: header.readInt32BE(2),
    body: body.toString()
  }
}

function isComplete (buf) {
  if (buf.length < 6) {
    return 0;
  }
  return 6 + buf.readInt32BE(2);
}

ids.forEach(id => {
  client.write(encode(id));
});