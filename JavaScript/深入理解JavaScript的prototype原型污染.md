百科：JavaScript 是一种直译式脚本语言，是一种动态类型、弱类型、基于原型的语言，内置支持类型。

### 原型对象与原型链

参考：[JavaScript原型对象与原型链的概念](https://github.com/zymfe/notebook/blob/master/JavaScript/JavaScript%E5%8E%9F%E5%9E%8B%E5%AF%B9%E8%B1%A1%E4%B8%8E%E5%8E%9F%E5%9E%8B%E9%93%BE%E7%9A%84%E6%A6%82%E5%BF%B5.md);

### JavaScript 原型链继承

因为有了原型链的机制，所以可以根据原型链实现继承。

``` javascript
function Animal () {
  this.color = 'black';
  this.age = 10;
}

function Dog () {
  this.color = 'white';
}

Dog.prototype = new Animal();

var d = new Dog();
console.log(d.color, d.age); // white 10
```

### 什么是原型链污染

实例对象的__proto__指向构造函数的 prototype，那么，如果我们修改了原型指针中的某个属性值，会发生什么事情呢？看下具体的代码实现：

``` javascript
var o1 = { a: 1 };

console.log(o1.a); // 1

o1.__proto__.a = 2;

console.log(o1.a); // 1

var o2 = {};

console.log(o2.a); // 2
```

定义 o2 对象之后，并未添加任何属性，但是最后打印显示 o2 有 a 属性，说明前面我们修改了 o1 原型指针指向的的原型对象。

``` javascript
o1.__proto__.a = 2
```

最重要的是 o1 是 Object 类的实例，所以实际上是修改了 Object.prototype ，给这个对象添加了一个 a 属性，后面所有基于 Object 创建的对象，默认都会有 a 属性。

### 什么情况下会出现原型污染

以上解释了原型污染的原理，那么在实际开发过程中，原型污染大多出现在属性赋值时，常见的比如 对象合并、克隆。

写了个原型污染的 demo，代码参考：[https://github.com/zymfe/test-code/blob/master/test75.js](https://github.com/zymfe/test-code/blob/master/test75.js)

### 注意

本文最后编辑于2019/07/11，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。