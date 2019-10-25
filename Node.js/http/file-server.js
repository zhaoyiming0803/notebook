const http = require('http');
const url = require('url');
const path = require('path');
const fs = require('fs');

const port = 3001;
const hostname = 'localhost';

const server = http.createServer((req, res) => {
  const pathname = url.parse(req.url).pathname;
  const filepath = path.join(__dirname, pathname);
  fs.stat(filepath, (err, stats) => {
    if (!err && stats.isFile()) {
      console.log('200 ' + req.url);
      res.writeHead(200);
      // 没有必要手动读取文件内容。由于response对象本身是一个Writable Stream，
      // 直接用pipe()方法就实现了自动读取文件内容并输出到HTTP响应
      fs.createReadStream(filepath).pipe(res);
    } else {
      console.log('404 ' + req.url);
      res.writeHead(404);
      res.end('404 Not Found');
    }
  });
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});