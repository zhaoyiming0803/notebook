const http = require('http')

const server = http.createServer((req, res) => {
  res.statusCode = 200
  // setTimeout(() => {
  //   console.log(window.location.url)
  // })
  res.end('hello world')
})

server.listen(3000, () => {
  console.log('listen at 3000')
})


process.on('uncaughtException', e => {
  console.log('uncaughtException: ', e)
  // ...上报：代码等错误
  process.exit(1)
})

setInterval(() => {
  const rss = process.memoryUsage().rss
  if (rss > 1024 * 10000) {
    // 上报：可能内存泄露
    console.log('rss: ', rss)
    process.exit(2)
  }
}, 5000)

process.on('message', str => {
  if (str === 'ping') {
    process.send('pong')
  }
})