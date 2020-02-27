const net = require('net')
const { ids } = require('../config')
const client = new net.Socket()

client.connect({
  host: '127.0.0.1',
  port: 3000
})

let remnant = null

client.on('data', buf => {
  console.log(buf)
  if (remnant) {
    buf = Buffer.concat([ remnant, buf ])
  }
  let packageLength = 0
  while (packageLength = isComplete(buf)) {
    const package = buf.slice(0, packageLength)
    buf = buf.slice(packageLength)
    const content = decode(package)
    console.log(content)
  }
  remnant = buf
})

client.on('end', e => {
  console.log('client end')
})

client.on('error', e => {
  console.log('client error: ', e)
})

let seq = 0

function encode (id) {
  const body = Buffer.alloc(4)
  body.writeInt32BE(id)

  const header = Buffer.alloc(6)
  header.writeInt16BE(seq++, 0)
  header.writeInt32BE(body.length, 2)

  return Buffer.concat([ header, body ])
}

function decode (package) {
  const header = package.slice(0, 6)
  const seq = header.readInt16BE(0)
  const bodyLength = header.readInt32BE(2)
  const body = package.slice(6).toString()
  return { seq, bodyLength, body }
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

ids.forEach(id => client.write(encode(id)))