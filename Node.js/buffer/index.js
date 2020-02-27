
// Int16  意思是16位整数(16bit integer)，相当于short  占2个字节   -32768 ~ 32767

// Int32  意思是32位整数(32bit integer), 相当于 int      占4个字节   -2147483648 ~ 2147483647

// Int64  意思是64位整数(64bit interger), 相当于 long long   占8个字节   -9223372036854775808 ~ 9223372036854775807

// Byte  相当于byte(unsigned char)   0 ~ 255

// WORD 等于  unsigned short     0 ~ 65535

console.log(Buffer.from('hello world'));

console.log(Buffer.from([1, 2, 3, 'A', 'b']));

console.log(Buffer.from('node.js').toString());

const buf1 = Buffer.from('hello ');
const buf2 = Buffer.from('world');
// 分配的空间越大，占用的内存越多
const buf3 = Buffer.concat([buf1, buf2], 50);
// const buf3 = Buffer.concat([buf1, buf2]);
console.log('buf3: ', buf3);
console.log(buf3.toString());
buf3[20] = '01';
console.log('buf3: ', buf3);
console.log('buf3 string: ', buf3.toString())

console.log(Buffer.isBuffer(buf3));
console.log(Buffer.isBuffer([1]));

console.log(Buffer.isEncoding('utf-8'));
console.log(Buffer.isEncoding('xxx'));

console.log('----------');
const buf4 = Buffer.alloc(5);
console.log(buf4);
buf4.writeInt32BE(Buffer.from('12345'), 0);
console.log(buf4);

console.log('------------');

const buf5 = Buffer.alloc(8);
buf5.writeInt32BE(0x01020304, 0);
console.log(buf5);
buf5.writeInt32LE(0x05060708, 4);
console.log(buf5);
console.log(buf5.toString('utf8'));

console.log('----------------------------');

const header = Buffer.alloc(6);
header.writeInt16BE('123', 0);
header.writeInt32BE('500', 2);

const body = Buffer.from('hello world');

const content = Buffer.concat([header, body]);

const a = content.readInt16BE();
const b = content.readInt32BE(2);
const c = content.slice(6);
console.log(a);
console.log(b);
console.log(c.toString());
