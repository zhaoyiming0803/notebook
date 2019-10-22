之前的笔记《[0.1+0.2!=0.3](https://github.com/zymfe/notebook/blob/master/JavaScript/0.1%2B0.2%20!%3D%200.3%20%E7%9A%84%E5%8E%9F%E5%9B%A0.md)》有介绍过小数运算误差产生的原因，下面来看看具体的解决方法：

### 使用第三方库：

[Math.js](https://mathjs.org/)

[decimal.js](http://mikemcl.github.io/decimal.js/)

[big.js](http://mikemcl.github.io/big.js/)

### 自己封装方法

精度丢失是因为小数尾数的转成二进制无穷尽，尾数超出52位就自动截断了，再转为10进制，就造成了误差。

那我们在运算的过程中，先把小数等比例放大n倍转为整数，得到结果之后，再除以n，不就是最终的结果吗？

以小数加法运算为例：

``` javascript
function add (a, b) {
  var r1, r2;

  try {
    r1 = a.toString().split('.')[1].length;
  } catch (e) {
    r1 = 0;
  }

  try {
    r2 = b.toString().split('.')[1].length;
  } catch (e) {
    r2 = 0;
  }

  var v = Math.max(r1, r2) * 10;

  return (a * v + b * v) / v;
}

console.log(add(0.1, 0.2)); / 0.3
```