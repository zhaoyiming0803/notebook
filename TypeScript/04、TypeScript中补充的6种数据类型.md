### 元组

元组可以看做是数组的拓展，它表示已知元素数量和类型的数组，确切的说，是已知数组中每一个位置上的元素的类型：

``` typescript
let arr: [number, string, Boolean];
arr = [1, '1', true];
arr = [1, 1, false]; // Type 'number' is not assignable to type 'string'.
arr = [1, '1']; // Property '2' is missing in type '[number, string]' but required in type '[number, string, Boolean]'.
```

可以给单个元素赋值：

``` typescript
arr[1] = '0';
```

当我们访问元组中的元素时，TypeScript 会对我们在元素上做的操作进行检查：

``` typescript
arr[0].split(''); // Property 'split' does not exist on type 'number'.
```

[string, number] 元组类型的声明效果上可以看做等同于下面的声明：

``` typescript
interface arr extends Array<number | string> {
  0: string;
  1: number;
  length: 2
}
```

### 枚举

enum 类型在 C++ 这些语言中较常见，TypeScript 在 ES 原有类型基础上加入枚举类型，使我们在 TypeScript 中也可以给一组数值赋予名字，这样对开发者来说较为友好，比如我们要定义一组角色，每一个角色用一个数字表示，就可以用枚举类型来定义：

``` typescript
enum Roles {
  SUPER_ADMIN,
  TEACHER,
  STUDENT
}

console.log(Roles['SUPER_ADMIN']); // 0
console.log(Roles['TEACHER']);     // 1
console.log(Roles['STUDENT']);     // 2
console.log(Roles['TEST']);        // Element implicitly has an 'any' type because index expression is not of type 'number'.
```

上面定义的枚举类型 Roles 里面有三个值，TypeScript 会为它们每个值分配编号，默认从 0 开始，依次排列，所以它们对应的值是：

``` typescript
enum Roles {
  SUPER_ADMIN = 0,
  TEACHER = 1,
  STUDENT = 2
}
```

当我们使用的时候，就可以使用名字而不需要记数组和名称的对照关系了。

我们也可以修改这个值，比如让这个编码从 1 开始而不是 0，可以如下定义：

``` typescript
enum Roles {
  SUPER_ADMIN = 1,
  TEACHER,
  STUDENT
}
```

这样，当我们访问 Roles.TEACHER时，它的值就是2了。

也可以单独为每个值赋值，不一定按顺序排列：

``` typescript
enum Roles {
  SUPER_ADMIN = 1,
  TEACHER = 5,
  STUDENT = 10
}
```

### any

JavaScript 的类型时灵活的，程序有时也是多变的。我们在编写代码时，并不能清楚的知道一个值到底是什么类型，这样就需要用到 any 类型，即任意类型：

``` typescript
let value: any = [];
value = 1;
value = '1';
value = false;
console.log(value); // false
```

我们还可以在定义数组类型时使用 any 来指定数组中的元素类型为任意类型：

``` typescript
const arr: any[] = [1, '1', false, { a: 1, b: 2 }];
console.log(arr);
```

但是请注意，不要滥用 any，如果任何值都被指定为 any 类型，那么 TypeScript 将失去它的意义。

所以如果类型是未知的，更安全的做法是使用 unknown 类型，后面笔记详述。

### void

void 与 any 相反，any 是表示任意类型，而 void 是表示没有任意类型，就是什么类型都不是，这在我们定义函数，函数没有返回值时会用到：

``` typescript
function fn(field: string): void {
  console.log(field);
}
fn('Hello TypeScript');
```

这个函数没有返回任何值，所以它的返回类型为 void，后面函数相关笔记中还会详述 void 类型。

void 类型的变量只能赋值为 undefined，其他类型不能赋值给 void 类型的变量，如：

``` typescript
let a: void = undefined;
a = null; // Type 'null' is not assignable to type 'void'
```

### never

never 类型指那些用不存在的值的类型，它是那些总会抛出异常或根本互惠有返回值的函数表达式的返回值类型，当变量被用不为真的类型保护所约束时，该变量也是 never 类型。

``` typescript
function fn(message: string): never {
  throw new Error('报错了');
}
fn('hello world');
```

以上代码：fn 函数总是会抛出异常，所以它的返回值类型是 never，用来表明它的返回值的用不存在的。

``` typescript
function fn(): never {
  while (true) { }
}
fn();
```

以上代码：fn 函数是个死循环，永远不会有返回值，它和 void 类型不同，void 函数表示函数没有返回值，因为我们在定义函数时没有给它指定返回值，而以上 fn 函数是死循环，根本不可能有返回值。

never 类型是任何类型的子类型，所以它可以赋值给任何类型。而没有类型是 never 的子类型，所以除了它本身没有任何类型可以赋值给 never 类型，any 类型也不能赋值给 never 类型，如：

``` typescript
let fn = (): never => {
  throw new Error('出错了');
}
fn = 123; // Type '123' is not assignable to type '() => never'.
```

### unknown

unknown 类型是 TypeScript 在 3.0 版本新增的类型，它表示未知类型，这样看来它貌似和 any 很像，但还是有区别的，也就是所谓的『unknown相对于any是安全的』。怎么理解呢？我们知道，当一个值我们不能确定它的类型时，可以指定它是 any 类型，但指定 any 类型后，这个值基本上『废』了，你可以随意对它进行访问和赋值，这往往会产生问题，如：

``` typescript
let value: any = {};
value = 123;
value.a = 'a';
console.log(value);
```

以上代码在编译时都不会报错，但是运行时绝对报错，因为 value 是 any 类型，所以后面的操作都是合法的，当 value 是一个对象时，访问 a 属性是没问题的，当 value 是数值类型是，访问它的 a 属性，就会报错。

而当你指定值为 unknown 类型时，如果没有通过基于控制流的类型断言来缩小范围的话，是不能对它进行任意操作的。

这里先了解 unknown 和 any 的区别，unknown 还有很多复杂的规则，后面的笔记详述。

### 交叉类型

交叉类型就是取多个类型的并集，使用 & 符号定义，被 & 符 链接的多个类型构成一个交叉类型，表示这个类型同时具备这几个链接起来的类型的特点，代码如下：

``` typescript
const merge = <T, U>(arg1: T, arg2: U): T & U => {
  let res = <T & U>{}; // 这里指定返回值的类型兼备T和U两个类型变量代表的类型的特点
  res = Object.assign(arg1, arg2); // 这里使用Object.assign方法，返回一个合并后的对象；
  return res;
};
const info1 = {
  name: "zhaoyiming"
};
const info2 = {
  age: 18
};
const person = merge(info1, info2);

console.log(person);
// console.log(person.address); // Property 'address' does not exist on type '{ name: string; } & { age: number; }'.
```

merge 方法也可以这样写：

``` typescript
function merge<T, U>(a: T, b: U): T & U {
  const result = <T & U>{};
  for (let prop in a) { // 使用类型断言，否则报错
    result[prop] = a[prop] as any;
  }
  for (let prop in b) {
    result[prop] = b[prop] as any;
  }
  return result;
}
```

``` typescript
const custom = <T>(field: T): T => {
  let res = <T>field;
  return res;
}
console.log(custom(1));
```

### 联合类型

联合类型实际是几个类型的结合，但是和交叉类型不同，联合类型是要求只要符合联合类型中任意一种类型即可，它使用 | 符号定义。

当我们程序具有多样性，元素类型不唯一时，即使用联合类型：

``` typescript
const getLength = (content: string | number): number => {
  if (typeof content === "string") return content.length;
  else return content.toString().length;
};
console.log(getLength("abc")); // 3
console.log(getLength(123)); // 3
```

![https://img.mukewang.com/5cf4bf5e0001c4e116001100.jpg](https://img.mukewang.com/5cf4bf5e0001c4e116001100.jpg)

### 注意

本文最后编辑于2019/06/25，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。