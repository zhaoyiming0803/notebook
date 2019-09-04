const a = require('./a');
const b = require('./b');
const c = require('./c');
const d = require('./d/d');

console.log(a());
console.log(b());
console.log(c.default());
console.log(d());

// module.exports = exports （两个对象指向同一个内存地址）
// 但是 nodejs 使用 module.exports 导出的值
// 因此不能给 exports 直接赋值，如 exports = () => 123
// 只能给 exports 添加属性，如：exports.a = () => 123，相当于 module.exports.a = () => 123

// 加载一个模块的顺序，如：require('./a')
// 在目录正确的情况下，首先试着寻找 a.js
// 如果 a.js 不存在，则找 a/index.js
// 如果直接写 require('a')，那么会去 node_modules 目录下找相应的模块
