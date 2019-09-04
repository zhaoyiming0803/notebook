const fs = require('fs');

const rs = fs.createReadStream('./stream/README.md', 'utf-8');

rs.on('data', chunk => {
  console.log(chunk);
});

rs.on('end', () => {
  console.log('fs end');
});

rs.on('error', () => {
  console.log('fs error');
});

const ws1 = fs.createWriteStream('./stream/1.txt', 'utf-8');
const str = 'hello \n' + Date.now();
str.split('').forEach(data => {;
  ws1.write(data);
});
ws1.end();

const ws2 = fs.createWriteStream('./stream/2.txt');
ws2.write(Buffer.from('使用Stream写入二进制数据...\n', 'utf-8'));
ws2.write(Buffer.from('END.', 'utf-8'));
ws2.end();

const pipeRs = fs.createReadStream('./stream/README.md', 'utf-8');
const pipeWs = fs.createWriteStream('./stream/3.txt', 'utf-8');
// 默认情况下，当Readable流的数据读取完毕，end事件触发后，将自动关闭Writable流。
// 如果我们不希望自动关闭Writable流，需要传入参数：
pipeRs.pipe(pipeWs, { end: false });