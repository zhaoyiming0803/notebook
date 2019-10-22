
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