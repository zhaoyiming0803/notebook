const net = require('net');
const { userMap } = require('../config');

const server = net.createServer(socket => {
  let remnat = null;

  socket.on('data', buf => {
    let packageLength = 0;

    if (remnat) {
      buf = Buffer.concat([remnat, buf]);
    }

    while (packageLength = isComplete(buf)) {
      const package = buf.slice(0, packageLength);
      buf = buf.slice(packageLength);
      remnat = null;
      const content = decode(package);
      console.log(content);
      setTimeout(() => {
        socket.write(encode(content));
      }, Math.random() * 2000);
    }

    remnat = buf;
  });
});

function decode (buf) {
  const header = buf.slice(0, 6);
  const seq = header.readInt16BE(0);
  const body = buf.slice(6).readInt32BE();
  return {
    seq,
    data: body
  }
}

function encode (content) {
  const body = Buffer.from(userMap[content.data]);

  const header = Buffer.alloc(6);
  header.writeInt16BE(content.seq);
  header.writeInt32BE(body.length, 2);

  return Buffer.concat([header, body]);
}

function isComplete (buf) {
  if (buf.length < 6) {
    return 0;
  }
  return 6 + buf.readInt32BE(2); // header 的长度 + body 的长度
}

server.listen(3000);