做WEB前端开发所必须的三个技能（HTML、CSS、JavaScript）中，只有 JavaScript 能算作是一门编程语言，做 JS 也不能仅仅满足于实现几个简单的动画效果，而是要理解 JavaScript 的核心，这样才能更加深刻的理解这门语言，也为我们学习其他的编程语言打下基础。例如我们今天要说的 JavaScript 中原型对象与原型链的概念。

这里总共涉及到3个概念：原型指针__proto__、原型对象、原型链。

今天要用到的测试代码：

``` javascript
function Person (name, age, work) {
  this.name = name;
  this.age = age;
  this.work = work;
}

Person.prototype.printName = function () {
  console.log(this.name);
}

var person = new Person('zhaoyiming', 18, 'FE');

console.log(person.__proto__ === Person.prototype); // true
```

### 原型指针__proto__：

在 JavaScript中，每个对象都拥有一个原型对象，而指向该原型对象的内部指针则是 __proto__ ,通过它可以从中继承原型对象的属性，原型是 JavaScript 中的基因链接，有了这个，才能知道这个对象的祖祖辈辈。从对象中的 __proto__ 可以访问到他所继承的原型对象。

上面的代码说明对象 person 的原型指针指向了 Person.prototype。

而 Person.prototype 也是一个对象（在 JavaScript 中万物皆为对象，可以简单这样理解），所以它的原型也有具体执行，例如下面的代码：

``` javascript
console.log(Person.prototype.__proto__); // Object
```

构造函数的原型指向是对象 Object。这就说明，Person本身也是继承自 Object 的，那么 Object 的原型指向的是谁呢？看下面的代码：

``` javascript
console.log(person.__proto__.__proto__.__proto__); // null
```

附带一张 JavaScript 对象指针图：

![https://github.com/zymfe/notebook/uploads/images/384.jpg](https://github.com/zymfe/notebook/uploads/images/384.jpg)

所以说，JavaScript中的对象，追根溯源都是来自一个 null 对象。

除了使用.__proto__方式访问对象的原型，还可以通过 Object.getPrototypeOf 方法来获取对象的原型，以及通过Object.setPrototypeOf 方法来重写对象的原型 。

值得注意的是，按照语言标准，__proto__ 属性只有浏览器才需要部署，其他环境可以没有这个属性，而且前后的两根下划线，表示它本质是一个内部属性，不应该对使用者暴露。因此，应该尽量少用这个属性，而是用 Object.getPrototypeof 和Object.setPrototypeOf，进行原型对象的读写操作。

这里用__proto__属性来描述对象中的原型，是因为这样来得更加形象，且容易理解。

### JavaScript原型对象 prototype

在 JavaScript 中，构造函数也是一个对象，所以它也有对象指针，拿上面的例子来说，如下代码：</p>

``` javascript
console.log(Person.__proto__ === Function.prototype); // true
```

函数实例除了拥有 __proto__ 属性之外，还拥有 prototype 属性。通过该函数构造的新的实例对象，其原型指针 __proto__ 会指向该函数的 prototype 属性。

而函数的 prototype 属性，本身是一个由 Object 构造的实例对象。

``` javascript
console.log(Person.prototype.__proto__ === Object.prototype); // true
// prototype 属性很特殊，它还有一个隐式的 constructor，指向了构造函数本身。
console.log(Person.prototype.constructor === Person); // true
console.log(person.constructor); // Person
console.log(person.constructor === Person.prototype.constructor); // true
```

![https://github.com/zymfe/notebook/uploads/images/385.jpg](https://github.com/zymfe/notebook/uploads/images/385.jpg)

### JavaScript原型链的概念

原型链作为实现继承的主要方法，其基本思想是利用原型让一个引用类型继承另一个引用类型的属性和方法。

每个构造函数都有一个原型对象(prototype)，原型对象都包含一个指向构造函数的指针(constructor)，而实例都包含一个指向原型对象的内部指针(proto)

那么，假如我们让原型对象等于另一个类型的实例，此时的原型对象将包含一个指向另一个原型的指针，相应地，另一个原型中也包含着一个指向另一个构造函数的指针。假如另一个原型又是另一个类型的实例，那么上述关系依然成立。

如此层层递进，就构造了实例与原型的链条，这就是原型链的基本概念。

原型链的作用在于，当读取对象的某个属性时，JavaScript 引擎先寻找对象本身的属性，如果找不到，就到它的原型去找，如果还是找不到，就到原型的原型去找。以此类推，如果直到最顶层的 Object.prototype 还是找不到，则返回 undefined。

instanceof 运算符返回一个布尔值，表示一个对象是否由某个构造函数创建。

Object.isPrototypeOf 只要某个对象处在原型链上，isProtypeOf 都返回 true。

``` javascript
console.log(person instanceof Person); // true
```

``` javascript
console.log(Person.prototype.isPrototypeOf(person)); // true
```
	
要注意，实例 person 的原型是 Person.prototype 而不是 Person。

下面是一张JavaScript原型链分析图：

![https://github.com/zymfe/notebook/uploads/images/386.jpg](https://github.com/zymfe/notebook/uploads/images/386.jpg)

这是一张描述了Object、Function以及一个函数实例Foo他们之间原型之间联系。如果理解了上面的概念，这张图是不难读懂。

从上图中，能看到一个有趣的地方。

Function.prototype.proto 指向了 Object.prototype，这说明 Function.prototype 是一个 Object实例，那么应当是先有的 Object 再有Function。
 
但是 Object.prototype.constructor.proto 又指向了 Function.prototype。这样看来，没有Function，Object也不能创建实例。

这就产生了一种类「先有鸡还是先有蛋」的经典问题，到底是先有的 Object 还是先有的 Function 呢？

以下代码作为辅助理解原型链的概念：

``` javascript
function P1 () {
	this.name = name || 'john';
}

P1.prototype.name = 'mark';

function P2 (name) {
	this.name = name;
}

P2.prototype.name = 'mark';

function P3 () {
	this.name = name;
}

P3.prototype.name = 'mark';

function P4(){}

P4.prototype.name = 'mark';

console.log(new P1('haha').name); // john
console.log(new P2().name); // undefined
console.log(new P3().name); // error: name is not defined
console.log(new P4().name); // mark
```

### 注意

本文最后编辑于2019/07/11，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。