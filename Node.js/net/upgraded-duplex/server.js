const net = require('net')
const { userMap } = require('../config')

const server = net.createServer(socket => {
  let remnant = null

  socket.on('data', buf => {
    if (remnant) {
      buf = Buffer.concat([ remnant, buf ])
    }

    let packageLength = 0
    while (packageLength = isComplete(buf)) {
      const package = buf.slice(0, packageLength)
      buf = buf.slice(packageLength)
      const content = decode(package)
      console.log(content)
      setTimeout(() => {
        const res = encode(content)
        console.log(res)
        socket.write(res)
      }, Math.random() * 1000)
    }

    remnant = buf
  })
})

function encode (content) {
  const body = Buffer.from(userMap[content.body])
  const header = Buffer.alloc(6)
  header.writeInt16BE(content.seq, 0)
  header.writeInt32BE(body.length, 2)
  
  return Buffer.concat([header, body])
}

function decode (package) {
  const header = package.slice(0, 6)
  const seq = header.readInt16BE(0)
  const body = package.slice(6).readInt32BE()
  return { seq, body }
}

function isComplete (buf) {
  if (buf.length <= 6) {
    return 0
  }

  const bodyLength = buf.slice(0, 6).readInt32BE(2)
  if (buf.length < 6 + bodyLength) {
    return 0
  }

  return 6 + bodyLength // 一个完整包的长度 = header长度 + body长度
}

server.listen(3000)