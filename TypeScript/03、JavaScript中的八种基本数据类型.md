### 数值

为一个变量指定类型的语法是使用"变量: 类型"的形式，如下：

``` typescript
let num: number = 123;
```

如果你没有为这个变量指定类型，编译器会自动根据你赋给这个变量的值来推断这个变量的类型：

``` typescript
let num = 123;
num = '456'; // Type '"456"' is not assignable to type 'number'.
```

当我们给 num 赋值为123但没有指定类型时，编译器推断出了 num 的类型为 number 数值类型，所以当给 num 再赋值为字符串"456"时，就会报错。

这里还有一点要注意，就是 number 和 Number 的区别：TS中指定类型的时候要用 number，这个是TypeScript的类型关键字。而 Number 为JavaScript的原生构造函数，用它来创建数值类型的值，它俩是不一样的。包括 string、boolean 等都是TypeScript的类型关键字，不是JavaScript语法，这点要区分开。

### 布尔类型

类型为布尔类型的变量的值只能是 true 或 false，如下：

``` typescript
let bool: boolean = true;
bool = false;
bool = 123; // Type '123' is not assignable to type 'boolean'.
```

当然了，赋给 bool 的值也可以是一个计算之后结果是布尔值的表达式，比如：

``` typescript
let bool: boolean = !!'123';
console.log(bool); // true
```

### 数值类型

TypeScript 和 JavaScript 一样，所有数字都是浮点数，所以只有一个 number 类型，而没有 int 或者 float 类型。而且 TypeScript 还支持 ES6 中新增的二进制和八进制数字字面量，所以 TypeScript 中共支持二、八、十和十六四种进制的数值。

``` typescript
let num: number;
num = 123;
num = "123";      // Type '"123"' is not assignable to type 'number'.
num = 0b1111011;  // 二进制的 123
num = 0o173;      // 八进制的 123
num = 0x7b;       // 十六进制的 123
```

### 字符串

``` typescript
let userName: string = 'zhaoyiming';
const first = 'yiming';
const last = 'zhao';
userName = `${first} ${last}`;
console.log(userName); // yiming zhao
```

字符串类型中你可以使用单引号和双引号包裹内容，但是可能你使用的 tslint 规则会对引号进行检测，使用单引号还是双引号可以在 tslint 规则里配置。你还可以使用 ES6 语法——模板字符串，拼接变量和字符串更为方便。

另外还有个和字符串相关的类型：字符串字面量类型。即把一个字符串字面量作为一种类型，比如上面的字符串"zhaoyiming"，当你把一个变量指定为这个字符串类型的时候，就不能再赋值为其他字符串值了，如：

``` typescript
let userName: 'zhaoyiming'
userName = 'zhangsan' // Type '"zhangsan"' is not assignable to type '"zhaoyiming"'.
```

### 数组

在 TypeScript 中有两种定义数组的方式：

``` typescript
const arr1: number[] = [1, 2, 3];
const arr2: Array<string> = ['1', '2', '3'];
```

第一种形式通过 number[] 的形式来指定这个类型元素均为number类型的数组类型，这种写法是推荐的写法，当然你也可以使用第二种写法。注意，这两种写法中的 number 指定的是数组元素的类型，你也可以在这里将数组的元素指定为任意类型。如果你要指定一个数组里的元素既可以是数值也可以是字符串，那么你可以使用这种方式：number|string[]。

当你使用第二种形式定义时，tslint 可能会警告让你使用第一种形式定义，如果你就是想用第二种形式，可以通过在 tslint.json 的 rules 中加入 "array-type": false 关闭 tslint 对这条的检测。

### 2.1.5 null 和 undefined

null 和 undefined 有一些共同特点，因为在 JavaScript 中，undefined 和 null 是两个基本数据类型。在 TypeScript 中，这两者都有各自的类型即 undefined 和 null，也就是说它们既是实际的值，也是类型，来看实际例子：

``` typescript
let u: undefined = undefined;
let n: null = null; 
```

这里可能会报一个tslint的错误：Unnecessary initialization to 'undefined'，就是不能给一个值赋undefined，但我们知道这是可以的，所以如果你的代码规范想让这种代码合理化，可以配置tslint，将"no-unnecessary-initializer"设为false即可。

默认情况下 undefined 和 null 可以赋值给任意类型的值，也就是说你可以把 undefined 赋值给 void 类型，也可以赋值给 number 类型。当你在 tsconfig.json 的"compilerOptions"里设置了 "strictNullChecks": true 时，那必须严格对待。undefined 和 null 将只能赋值给它们自身和 void 类型。

### object

object 在 JS 中是引用类型，它和 JS 中的其他基本类型不一样，像 number、string、boolean、undefined、null 这些都是基本类型，这些类型的变量存的是他们的值，而 object 类型的变量存的是引用，看个简单的例子：

``` typescript
let strInit = "abc";
let strClone = strInit;
strClone = "efg";
console.log(strInit); // 'abc'

let objInit = { a: "aa" };
let objClone = objInit;
console.log(objClone) // {a:"aa"}
objInit.a = "bb";
console.log(objClone); // { a: 'bb' }
```

通过例子可以看出，我们修改 objInit 时，objClone 也被修改了，是因为 objClone 保存的是 objInit 的引用，实际上 objInit 和 objClone 是同一个对象。

当我们希望一个变量或者函数的参数的类型是一个对象的时候，使用这个类型，比如：

``` typescript
let obj: object
obj = { name: 'zhaoyiming' }
obj = 123 // Type '123' is not assignable to type 'object'.
```

这里有一点要注意了，你可能会想到给 obj 指定类型为 object 对象类型，然后给它赋值一个对象，后面通过属性访问操作符访问这个对象的某个属性，实际操作一下你就会发现会报错：

``` typescript
let obj: object
obj = { name: 'zhaoyiming' }
console.log(obj.name) // Property 'name' does not exist on type 'object'.
```

这里报错说类型 object 上没有 name 这个属性。如果你想要达到这种需求你应该使用接口，那 object 类型适合什么时候使用呢？当你希望一个值必须是对象而不是数值等类型时，比如我们定义一个函数，参数必须是对象，这个时候就用到object类型了：

``` typescript
function fn(options: object) {
  console.log(options);
}
console.log(fn({ a: 1, b: 2 }));
```

### symbol

Symbol 是 ES6 加入的新的基础数据类型，后面笔记中详解。

### 注意

本文最后编辑于2019/06/25，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。
