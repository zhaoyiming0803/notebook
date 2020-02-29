const http = require('http')

let count = 0

const server = http.createServer((req, res) => {
  process.send(++count)
  console.log(process.)
  res.statusCode = 200
  res.end('hello world')
})

server.listen(3000)