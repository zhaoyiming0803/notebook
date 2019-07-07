symbol 是 ES6 新增的一种基本数据类型，它和 number、string、boolean、undefined、null 是同类型的，object 是引用类型。它用来表示独一无二的值，通过 Symbol 函数生成。

小例子：

``` javascript
const s = Symbol();
console.log(typeof s); // symbol
```

我们使用 Symbol 函数生成了一个 symbol 类型的值。

### 注意

Symbol 前面不能加 new 关键字，直接调用即可创建一个独一无二的 symbol 类型的值。

我们可以使用 Symbol 方法创建 symbol 类型值的时候传入一个参数，这个参数需要是一个字符串，如果传入的参数不是字符串，会先调用传入参数的 toString 方法转为字符串，如：

``` javascript
const s1 = Symbol('zhaoyiming');
const s2 = Symbol('zhaoyiming');
console.log(s1 === s2); // false
// 以上第三行代码可能会报一个错误：This condition will always return 'false' since the types 'unique symbol' and 'unique symbol' have no overlap.
// 这是因为编译器检测到这里的s1 === s2始终是false，所以编译器提醒你这代码写的多余，建议你优化。
```

上面这个例子中使用 Symbol 方法创建了两个 symbol 值，方法中都传入了相同的字符串『zhaoyiming』，但是 s1 === s2 却是 false，这就是我们说的，Symbol 方法会返回一个独一无二的值，这个值和任何一个值都不等，虽然我们传入的标识字符串都是『zhaoyiming』，但却是两个不同的值。

可以理解为我们每一个人都是独一无二的，虽然可以有相同的名字，但是名字只是用来方便我们区分的，名字相同但人还是不同的。Symbol 方法传入的这个字符串，就是方便我们在控制台或程序中用来区分 symbol 值的，我们可以调用 symbol 值的 toString 方法将它转为字符串。

``` javascript
const s = Symbol('zhaoyiming');
console.log(s.toString()); // Symbol(zhaoyiming)
```

可以简单的理解 symbol 值为字符串类型的值，但是它和字符串有很大的区别，它不可以和其他类型的值进行运算，但是可以转为字符串和布尔类型值。

``` javascript
var s = Symbol('zhaoyiming');
console.log(s.toString()); // Symbol(zhaoyiming);
console.log(Boolean(s)); // true
console.log(!s); // false
```

通过上面的例子可以看出，symbol 类型值和对象相似，本身转为布尔值为 true，取反为 false。

### 作为属性名

在 ES6 中，对象的属性名支持表达式，所以可以使用一个变量作为属性名，这对于一些代码的简化很有用处，但是表达式必须放到方括号内。

``` javascript
var prop = 'name';
var obj = {
  [prop]: 'zhaoyiming'
}
console.log(obj.name); // zhaoyiming
```

symbol 值可以作为属性名，因为 symbol 值是独一无二的，所以当它作为属性名时，不会和其他任何属性名重复。

``` javascript
var name = Symbol();
var obj = {
  [name]: 'zhaoyiming'
}
console.log(obj); // {Symbol(): "zhaoyiming"}
```

可以看到，打印出来的对象有一个属性名是 symbol 值，如果想访问这个属性值，就只能使用 name 这个 symbol 值。

``` javascript
console.log(obj[name]); // zhaoyiming
console.log(obj.name); // undefined
```

通过上面的例子可以看出，我们访问属性名为 symbol 类型值的 name 时，我们不能使用点『.』号访问，因为 obj.name 的 name 实际上是字符串 name，这和访问普通字符串类型的属性名一样，你必须使用方括号的形式，这样 obj[name] 的 name 才是我们定义的 symbol 类型的变量 name，之后我们再访问 obj 的 [name] 属性就必须使用变量name。

ES6 的类（Class），会利用此特性实现私有属性和私有方法。

### 属性名的遍历

使用 Symbol 类型值作为属性名，这个属性不会被 for...in遍历到，也不会被 Object.keys()、Object.getOwnPropertyNames()、JSON.stringify() 获取到：

``` javascript
var name = Symbol('name');
var obj = {
  [name]: 'zhaoyiming',
  age: 18
}
for (var prop in obj) {
  console.log(prop); // age
}
console.log(Object.keys(obj)); // ['age']
console.log(Object.getOwnPropertyNames(obj)); // ['age']
console.log(JSON.stringify(obj)); // '{"age": 18}'
```

虽然这么多方法都无法遍历和访问 Symbol 类型的属性名，但是 Symbol 类型的属性并不是私有属性，我们可以使用 Object.getOwnPropertySymbols 方法获取对象的所有 symbol 类型的属性名：

``` javascript
var name = Symbol('name');
var obj = {
  [name]: 'zhaoyiming',
  age: 18
}
console.log(Object.getOwnPropertySymbols(obj)); // [Symbol(name)]
```

除了 Object.getOwnPropertySymbols 这个方法，还可以用 ES6 新提供给的 Reflect 对象的静态方法 Reflect.ownKeys，它可以返回所有类型的属性名，所以 Symbol 类型的也会返回。

``` javascript
var name = Symbol('name');
var obj = {
  [name]: 'zhaoyiming',
  age: 18
}
console.log(Reflect.ownKeys(obj)); // ['age', Symbol(name)]
```

### Symbol.for 和 Symbol.keFor

Symbol 包含两个静态方法， for 和 keyFor

1、Symbol.for

我们使用 Symbol 方法创建的 symbol 值是独一无二的，每个值都不和其他任何值相等，我们来看下例子：

``` javascript
var s1 = Symbol('zhaoyiming');
var s2 = Symbol('zhaoyiming');
var s3 = Symbol.for('zhaoyiming');
var s4 = Symbol.for('zhaoyiming');
console.log(s1 === s3); // false
console.log(s3 === s4); // true
```
直接使用 Symbol 方法，即便传入的字符串是一样的，创建的 symbol 也互不相等。而使用 Symbol.for 方法传入字符串，会先检查有没有使用该字符串调用 Symbol.for 方法创建的 symbol 值，如果有，返回该值，如果没有，则使用该字符串新创建一个。使用该方法创建 symbol 值会在全局范围进行注册。

### 注意

这个注册的范围包括当前页面和页面中包含的iframe，以及 service worker：

``` javascript
var iframe = document.createElement('iframe');
iframe.src = String(window.location);
document.body.appendChild(iframe);
console.log(iframe.contentWindow.Symbol.for('zhaoyiming') === Symbol.for('zhaoyiming')); // true
// 注意：如果你在JavaScript环境中这段代码是没有问题的，但是如果在TypeScript开发环境中，可能会报错：类型“Window”上不存在属性“Symbol”。
// 因为这里编译器推断出iframe.contentWindow是Window类型，但是TypeScript的声明文件中，对Window的定义缺少Symbol这个字段，所以会报错，所以你可以这样写：
// (iframe.contentWindow as Window & { Symbol: SymbolConstructor }).Symbol.for("lison") === Symbol.for("lison")
// 这里用到了类型断言和交叉类型，SymbolConstructor是内置的类型。
```
上面这段代码的意思是创建一个 iframe 节点并把它放到 body 中，我们通过这个 iframe 对象的 contentWindow 拿到这个 iframe 的 window 对象，在 iframe.contentWindow 上添加一个值就相当于你在当前页面定义一个全局变量一样，我们看到，在 iframe 中定义的键为 zhaoyiming 的 symbol 值在和在当前页面定义的键为 zhaoyiming 的 symbol 值相等，说明它们是同一个值。

2、Symbol.keyFor

该方法传入一个 symbol 值，返回该值在全局注册的键名：

``` javascript
var sym = Symbol.for('zhaoyiming');
console.log(Symbol.keyFor(sym)); // zhaoyiming
```

### 11个内置 symbol 值

ES6 提供了 11 个内置的 Symbol 值，指向 JS 内部使用的属性和方法，这些内置的 Symbol 值就是保存在 Synbol 上的，可以把 Symbol.xxx 看做一个 symbol 值。

1、Symbol.hasInstance

对象的 Symbol.hasInstance 指向一个内部方法，当你给一个对象设置以 Symbol.hasInstance 为属性名的方法后，当其他对象使用 instanceof 判断是否为这个对象的示例时，会调用你定义的这个方法，参数是其他的这个对象：

``` javascript
const obj = {
  [Symbol.hasInstance](otherObj) {
    console.log(otherObj);
  }
};
console.log({ a: "a" } instanceof obj); // false
// 注意：在TypeScript中这会报错，"instanceof" 表达式的右侧必须属于类型 "any"，或属于可分配给 "Function" 接口类型的类型。
// 是要求你instanceof操作符右侧的值只能是构造函数或者类，或者类型是any类型。这里你可以使用类型断言，将obj改为obj as any
```

可以看到当我们使用 instanceof 判断 { a: 'a' } 是否是 obj 创建的实例的时候，Symbol.hasInstance 这个方法被调用了。

2、Symbol.isConcatSpreadable

这个值是一个可读写布尔值，当一个数组的 Synbol.isConcatSpreadable 设为 true 时，这个数组在数组的 concat 方法中不会被扁平化：

``` javascript
var arr = [1, 2];
console.log([].concat(arr, [3, 4])); // [1, 2, 3, 4]

var arr1 = ['a', 'b'];
console.log(arr1[Symbol.isConcatSpreadable]); // undefined

arr1[Symbol.isConcatSpreadable] = false;
console.log(arr1[Symbol.isConcatSpreadable]); // false

console.log([].concat(arr1, [3, 4])); // [['a', 'b'], Symbol(Symbol.isConcatSpreadable): false, 3, 4]
```

3、Symbol.species

我们使用 Class 定义一个类 c，使用 extends 继承原生构造函数 Array，那么类 C 创建的实例就能继承所有 Array 原型对象上的方法，比如 map、filter等。

``` javascript
class C extends Array {
  getName () {
    return 'zhaoyiming'
  }
}
const c = new C(1, 2, 3);
const a = c.map(item => item + 1);
console.log(a); // [2, 3, 4]
console.log(a instanceof C); // true
console.log(a instanceof Array); // true
console.log(a.getName()); // 'zhaoyiming'
```

这个例子中，a 是由 c 通过 map 方法衍生出来的，从以上代码可以看到，a 既是 C 的实例，也是 Array 的实例，但是如果我们想只让衍生的数组是 Array 的实例，就需要 Symbol.species：

``` javascript
class C extends Array {
  static get [Symbol.species] () {
    return Array;
  }
  getName () {
    return 'zhaoyiming';
  }
}
const c = new C(1, 2, 3);
const a = c.map(item => item + 1);
console.log(a); // [2, 3, 4]
console.log(a instanceof C); // false
console.log(a instanceof Array); // true
console.log(a.getName()); // error a.getName is not a function
```

就是给类 C 定义一个静态 get 存取器方法，方法名为 Symbol.species，然后在这个方法中返回要构造衍生数组的构造函数，所以最后我们看到，a instanceof C 为 false，也就是 a 不再是 C 的实例，也无法调用继承自 C 的方法。

4、Symbol.match、Symbol.replace、Symbol.search 和 Symbol.split

这个 Symbol.match 值指向一个内部方法，当在字符串 str 上调用 match 方法时。会调用这个方法：

``` javascript
var obj = {
  [Symbol.match](string) {
    return string.length;
  }
}
console.log('abc'.match(obj)); // 3
```

相同的还有 Symbol.replace 、Symbol.search 和 Symbol.split ，使用方法和 Symbol.match 是一样的。

5、Symbol.iterator

数组的 Symbol.iterator 属性指向该数组的默认遍历器方法：

``` javascript
var arr = [1, 2, 3];
var iterator = arr[Symbol.iterator]();
console.log(iterator); // Array Iterator {}
console.log(iterator.next()); // {value: 1, done: false}
console.log(iterator.next()); // {value: 2, done: false}
console.log(iterator.next()); // {value: 3, done: false}
console.log(iterator.next()); // {value: undefined, done: true}
```
这个 Symbol.iterator 方法是可写的，我们可以自定义遍历器方法。

6、Symbol.toPrimitive

对象的这个属性指向一个方法，当这个对象被转为原始类型值时会调用这个方法，这个方法有一个参数，时这个对象被转为的类型：

``` javascript
var obj = {
  [Symbol.toPromitive](type) {
    console.log(type);
  }
};
var b = obj++; // number
var a = `abc$[obj}` // string
```

7、Symbol.toStringTag

Symbol.toStringTag 和 Symbol.toPrimitive 相似，对象的这个属性值可以是一个字符串，也可以时一个存取器 get 方法，当在对象上调用 toString 方法时，返回值将 "[object xxx]" 中 xxx 这个值：

``` javascript
var obj = {
  [Symbol.toStringTag]: 'zhaoyiming'
}
console.log(obj.toString()); // '[object zhaoyiming]'

var obj2 = {
  get [Symbol.toStringTag] () {
    return 'zymfe'
  }
}
console.log(obj.toString()); // '[object zymfe]'
```

9、Symbol.unscopables

这个值和 with 命令有关，with 的使用方法如下：

``` javascript
var obj = {
  a: 'a',
  b: 'b'
}
with (obj) {
  console.log(a); // 'a'
  console.log(b); // 'b'
}
// Typescript 中会报错，因为严格模式下不允许使用 with
```

可以看到，使用 with 传入一个对象后，在代码块中访问独享的属性就不需要写对象了，直接就可以用它的属性。对象的 Symbol.unscopables 属性指向一个对象，该对象包含了当使用 with 关键字时，哪些属性被 with 环境过滤掉：

``` javascript
console.log(Array.prototype[Symbol.unscopables]);
/*
{
  copyWithin: true
  entries: true
  fill: true
  find: true
  findIndex: true
  includes: true
  keys: true
  values: true
}
*/
```

### 在 TypeScript 中使用 Symbol 类型

``` typescript
let sym: symbol = Symbol();
```

TypeScript 在2.7版本做了补充，增加了 unique symbol 这种类型，它是 symbols 的子类型，这种类型的值只能由 Symbol 或 Symbol.for 创建，或者通过指定类型来指定一个值是这种类型。这种类型的值仅可用于常量的定义和用于属性名。

定义 unique symbol 类型的值，必须用 const 不能用 let：

``` typescript
const key1: unique symbol = Symbol()
let key2: symbol = Symbol()
const obj = {
  [key1]: 'value1',
  [key2]: 'value2'
}
console.log(obj[key1])
console.log(obj[key2]) // error 类型“symbol”不能作为索引类型使用。
```

![https://img.mukewang.com/5cf8c54f0001100216000744.jpg](https://img.mukewang.com/5cf8c54f0001100216000744.jpg)

### 注意

本文最后编辑于2019/06/28，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。