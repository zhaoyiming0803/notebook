// 当前脚本的命令是在 src 目录下执行的 node src/fs/index.js

const fs = require('fs');
const path = require('path');

fs.readFile('./fs/README.md', 'utf-8', (err, data) => {
  if (err) {
    console.log(err);
  } else {
    console.log(data);
  }
});

// 当读取二进制文件时，不传入文件编码时，回调函数的 data 参数将返回一个 Buffer 对象。
// 在 Node.js 中，Buffer 对象就是一个包含零个或任意个字节的数组（注意和Array不同）。
fs.readFile('./fs/css.png', (err, data) => {
  if (err) {
    console.log(err);
  } else {
    console.log(data);

    // 将二进制转为字符串
    const imgString = data.toString('utf-8');
    // 将字符串转为二进制
    const imgBuffer = Buffer.from(imgString);

    const res = fs.writeFileSync('./fs/css-copyed.png', data);
    if (res) {
      console.log(res);
    } else {
      console.log('css-copied ok');
    }
  }
});

fs.writeFile('./fs/README.txt', 'hello node.js', err => {
  if (err) {
    console.log(err);
  } else {
    console.log('README ok');
  }
});

function mkdirsSync (dirname) {
  if (fs.existsSync(dirname)) { 
    return true;  
  } else {  
    if (mkdirsSync(path.dirname(dirname))) {  
      console.log('dirname: ', dirname);
      fs.mkdirSync(dirname);  
      return true;  
    }  
  }  
}  

mkdirsSync('abc/def/dd');