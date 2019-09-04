// 参考 crypto 常用算法：
// https://github.com/michaelliao/learn-javascript/tree/master/samples/node/crypto

const crypto = require('crypto');

// MD5是一种常用的哈希算法，用于给任意数据一个“签名”。这个签名通常用一个十六进制的字符串表示：
// 可任意多次调用update():
// update()方法默认字符串编码为UTF-8，也可以传入Buffer
const md5 = crypto.createHash('md5');
md5.update('Hello, world!');
md5.update('Hello, nodejs!');
console.log('md5: ', md5.digest('hex'));

const sha1 = crypto.createHash('sha1');
sha1.update('Hello, world!');
sha1.update('Hello, nodejs!');
console.log('sha1: ', sha1.digest('hex'));

// Hmac算法也是一种哈希算法，它可以利用MD5或SHA1等哈希算法。不同的是，Hmac还需要一个密钥：
// 只要密钥发生了变化，那么同样的输入数据也会得到不同的签名，因此，可以把Hmac理解为用随机数“增强”的哈希算法。
const hmac = crypto.createHmac('sha256', 'secret-key');
hmac.update('Hello, world!');
hmac.update('Hello, nodejs!');
console.log('hmac: ', hmac.digest('hex'));

// AES是一种常用的对称加密算法，加解密都用同一个密钥。crypto模块提供了AES支持，但是需要自己封装好函数，便于使用：
function aesEncrypt (data, key) {
  const cipher = crypto.createCipher('aes192', key);
  let crypted = cipher.update(data, 'utf8', 'hex');
  crypted += cipher.final('hex');
  return crypted;
}

function aesDecrypt (encrypted, key) {
  const decipher = crypto.createDecipher('aes192', key);
  let decrypted = decipher.update(encrypted, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}

var data = 'Hello, this is a secret message!';
var key = 'Password!';
var encrypted = aesEncrypt(data, key);
var decrypted = aesDecrypt(encrypted, key);

console.log('Plain text: ' + data);
console.log('Encrypted text: ' + encrypted);
console.log('Decrypted text: ' + decrypted);