当我们要表示一个值可以为任意类型的时候，可以指定它的类型为 any，如：

``` typescript
const getArray = (value: any, times: number = 5): any[] => new Array(times).fill(value)
```
上面函数返回一个数组，每个元素都是 value，也就是说：传入的 value 是什么类型，返回的数组的每个元素也应该是什么类型。

下面实际执行 getArray 函数：

``` typescript
console.log(getArray([1], 2)); // [[1], 2]
console.log(getArray(3, 4)); // [3, 4]
```

要解决这种情况，泛型就可以搞定。

### 简单使用泛型

泛型（Generics）是指在定义函数、接口或类的时候，不预先指定具体的类型，而在使用的时候再指定类型的一种特性。

还是以上代码，我们既要允许传入任意类型的值，又要正确指定返回值类型，就要使用泛型：

``` typescript
const getArray = <T>(value: T, times: number = 5): T[] => new Array(times).fill(value);
```

我们在定义函数之前，使用 <> 符号定义了一个泛型变量 T，这个 T 在这次函数定义中就代表某一种类型，它可以是基础类型，也可以是联合类型等高级类型。定义了泛型变量之后，你在函数中任何需要指定类型的地方使用 T 都代表这一种类型。比如当我们传入 value 的类型为数值类型，那么返回的数组类型 T[] 就表示 number[]。

``` typescript
getArray<number[]>([1, 2], 3).forEach(item => {
  console.log(item.length);
});
getArray<number>(2, 3).forEach(item => {
  console.log(item.length); // 类型“number”上不存在属性“length”
});
```

我们在调用 getArray 的时候，在方法名后面使用 <> 传入了我们的泛型变量 T 的类型 number[]。那么在定义 getArray 函数时使用 T 指定类型的地方，都会使用 number[] 指定。但是也可以省略这个 <number[]>，TypeScript 会根据你传入函数的 value 值的类型进行推断。

``` typescript
getArray(2, 3).forEach(item => {
  console.log(item.length); // 类型 "number" 上不存在属性 length
});
```

### 泛型变量

当我们使用泛型的时候，你必须在处理类型涉及到泛型的数据的时候，把这个数据当做任意类型来处理，这就意味着不是所有类型都能做的操作不能做，不是所有类型都能调用的方法不能调用：

``` typescript
const getLength = <T>(param: T): number => param.length; // Property 'length' does not exist on type 'T'.
```
当我们获取一个类型为泛型的变量 param 的 length 属性时，如果 param 的类型为数组 Array 或字符串 string 类型是没问题的，它们有 length 属性。但是如果此时传入的 param 是数值 number 类型，就会有问题。

这里的 T 并不是固定的，你可以写为 A、B或者其他名字，而且还可以在一个函数中定义多个泛型变量：

``` typescript
const getArray = <T, U>(param1: T, param2: U, times: number): [T, U][] => {
  return new Array(times).fill([param1, param2]);
};

getArray(1, "a", 3).forEach(item => {
  console.log(item[0].length); // Property 'length' does not exist on type 'number'.
  console.log(item[1].toFixed(2)); // Property 'toFixed' does not exist on type 'string'. Did you mean 'fixed'?
});
```

以上代码中，我们定义了两个泛型变量 T 和 U，第一个参数的类型为 T，第二个参数的类型为 U，最后函数返回一个二维数组，函数返回类型我们指定是一个元素类型为[T, U]的数组。我们当我们调用函数，最后遍历结果时，遍历到的每个元素都是一个第一个元素是数值类型、第二个元素是字符串类型的数组。

### 泛型函数类型

我们可以定义一个泛型函数类型：

``` typescript
// 简单定义
const getArray: <T>(arg: T, times: number) => T[] = (arg, times) => {
  return new Array(times).fill(arg);
}
// 使用类型别名
type GetArray = <T>(arg: T, times: number) => T[];
const getArray: GetArray = <T>(arg: T, times: number): T[] => {
  return new Array(timers).fill(arg);
}
```

当然，我们也可以使用接口的形式来定义泛型函数类型：

``` typescript
interface GetArray {
  <T>(arg: T, times?: number): T[]
}
const getArray: GetArray = <T>(arg: T, times: number = 5): T[] => {
  return new Array(times).fill(arg);
}
```
还可以把接口中泛型变量提升到接口最外层，这样接口中所有属性和方法都能使用这个泛型变量了：

``` typescript
interface GetArray<T> {
  (arg: T, times: number): T[],
  tag: T
}
// Property 'tag' is missing in type '<T>(arg: T, times: number) => T[]' but required in type 'GetArray<number>'.
const getArray: GetArray<number> = <T>(arg: T, times: number): T[] => {
  return new Array(times).fill(arg);
}
getArray.tag = 'a'; // Type '"a"' is not assignable to type 'number'.
getArray('a', 1); // Argument of type '"a"' is not assignable to parameter of type 'number'.
```

以上代码中将泛型变量定义在接口最外层，所以不仅函数的类型中可以使用T，在属性 Tag 的定义中也可以使用。但在使用接口的时候，要在接口名后面明确传入一个类型，也就是这里的 getArray<number>，那么后面的 arg 和 tag 的类型都得是 number类型。如果希望 T 可以是任意类型，可以把 GetArray<number> 换成 GetArray<any>。

### 泛型约束

当我们使用泛型时，就以为这这个类型是任意类型，但在多数情况下，我们的逻辑是对特定类型处理的。比如上文的泛型变量，当访问一个泛型类型的参数的length属性时，会报错"类型 T 上不存在属性 length"，是因为并不是所有类型都有 length 属性。

所以我们在这里应该对 T 有要求，那就是类型为 T 的值应该包含 length 属性:

``` typescript
interface ValueWithLength {
  length: number
}
const v: ValueWithNumber = {}; // Property 'length' is missing in type '{}' but required in type 'ValueWithLength'.
```

泛型约束就是使用一个类型和 extends 对泛型进行约束，之前的例子就可以改为下面这样：

``` typescript
interface ValueWithLength {
  length: number
}
const getLength = <T extends ValueWithLength>(param: T): number => param.length;
getLength('abc'); // 3
getLength([1, 2, 3]); // 3
getLength({length: 3}); // 3
getLength(123); //
```
以上代码中，泛型变量 T 受到约束，它必须满足接口 ValueWithLength，也就是不管它是什么类型，但必须有一个 length 属性，且类型为数值类型。例子中后面四次调用 getLength 方法，传入了不同的值，传入参数 abc、[1, 2, 3]和一个包含 length 属性的对象 {length: 3}都是可以的，但是传入数值 123 不行，因为它没有 length 属性。

### 在泛型约束中使用类型参数

当我们定义一个对象，想要对只能访问对象上存在的属性做要求是，该怎么办？先来看这个需求是什么样子？

``` javascript
// js
const getProps = (object, propName) => object[propName];
const obj = {a: 'aa', b: 'bb'};
getProps(obj, 'c'); // undefined
```

当我们访问这个对象的 c 属性时，这个属性是没有的，这里我们需要用到索引类型 keyof 结合泛型来实现对这个问题的检查。

``` typescript
const getProp = <T, K extends keyof T>(object: T, propName: K) => object[propName];
const obj = {a: 'aa', b: 'bb'};
getProp(obj, 'c'); //  Argument of type '"c"' is not assignable to parameter of type '"a" | "b"'.
```
上面代码中，我们让 K 类继承索引类型 keyof T，可以理解为 keyof T 相当于一个由泛型变量 T 的属性名构成的联合类型，在这里 K 就被约束为只能是 a 或 b，所以当我们传入字符串 c 想要获取对象 obj 的属性 c 时就会报错。

![https://img.mukewang.com/5cf4c0120001489616000663.jpg](https://img.mukewang.com/5cf4c0120001489616000663.jpg)

### 注意

本文最后编辑于2019/07/02，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。