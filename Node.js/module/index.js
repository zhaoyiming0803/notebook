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
// 如果 a.js 不存在
  // 1、查找 a 目录下 package.json 中 main 字段对应的文件
  // 2、查找 a 目录下的 index.js
// 如果直接写 require('a')，那么会去 node_modules 目录下找相应的模块，写 require 的时候，vscode 会有提示

var testModule = require('test-module1');
console.log(testModule());
