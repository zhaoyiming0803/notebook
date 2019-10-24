const http = require('http');
const url = require('url');
const querystring = require('querystring');

const server = http.createServer((req, res) => {
  if (req.url !== '/favicon.ico') {
    const method = req.method.toUpperCase();
    let body = '';

    if (method === 'GET') {
      const query = url.parse(req.url).query;
      const queryObj = querystring.parse(query);
      console.log(queryObj);
    } else if (method === 'POST') {
      // POST 发送过来的是 Buffer 文件流
      req.on('data', buf => {
        body += buf;
      });
      req.on('end', () => {
        console.log(JSON.parse(body.toString()));
      });
    }
  }

  res.writeHead(200);
  res.end("123");
});

server.listen(3000);
