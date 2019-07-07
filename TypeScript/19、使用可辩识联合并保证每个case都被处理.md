我们可以把单例类型、联合类型、类型保护和类型别名这几种类型进行合并，来创建一个叫做『可辩识联合』的高级类型，它也可称作『标签联合』或『代数数据类型』。

所谓单例类型，你可以理解为符合『单例模式』的数据类型，比如枚举成员类型、字面量类型。

可辩识联合要求具有两个要素：

1、具有普通的单例类型属性（这个要作为辩识的特征，也是重要因素）。

2、一个类型别名，包含了那些类型的联合（即把几个类型封装为联合类型，并起一个别名）。

来看例子：

``` typescript
interface Square {
  kind: 'square'; // 这个就是具有辩识性的属性
  size: number
}

interface Rectangle {
  kind: 'ractangle'; // 这个就是具有辩识性的属性
  height: number;
  width: number;
}

interface Cilcle {
  kind: 'circle'; // 这个就是具有辩识性的属性
  radius: number
}

// 使用三个接口组成一个联合类型，并赋个一个别名 Shape，组成一个可辩识联合
type Shape = Square | Rectangle | Circle; 

function getArea (s: Shape) {
  switch (s.kind) {
    case 'square':
      return s.size * s.size;
    case 'recrangle':
      return s.height * s.width;
    case 'circle':
      // ES7 新特性：** 运算符，两个 * 符号组成的这个运算符就是求幂运算符，2 ** 3 = 8
      return Math.PI * s.radius ** 2;
  }
}
```
上面这个例子中，我们的 Shape 即可辩识联合，它时三个接口的联合，而这三个接口都有一个 kind 属性，且每个接口的 kind 属性值都不相同，能够起到标识作用。

通过上面的例子可以看到：函数内应该包含联合类型中每一个接口的 case，但是如果遗漏了，我们希望编译器能给出提示。所以来看下两种『完整性检查』的方法：

### 利用 strictNullChecks

我们给上面的例子加一种接口：

``` typescript
interface Square {
  kind: 'square';
  size: number;
}

interface Rectangle {
  kind: 'rectangle';
  height: number;
  width: number;
}

interface Circle {
  kind: 'circle';
  radius: number
}

interface Triangle {
  kind: 'triangle';
  bottom: number;
  height: number;
}

type Shape = Square | Rectangle | Circle | Triangle;

function getArea (s: Shape) {
  switch (s.kind) {
    case 'square':
      return s.size * s.size;
    case 'rectangle':
      return s.height * s.width;
    case 'circle':
      return Math.PI * s.radius ** 2;
  }
}
```

上面的例子中，我们的 Shape 联合有四种接口，但函数的 switch 里只包含三个 case，这个时候编译器并没有提示任何错误，因为当传入函数的类型是 Triangle 时，没有任何一个 case 符合，则不会有 return 语句执行，那么函数时默认返回 undefined。所以我们可以利用这个特点，结合 strictNullChecks 编译选项，我们可以开启 strictNullChecks，然后让函数的返回值类型为 number，那么当返回 undefined 的时候，就会报错。

``` typescript
function getArea(s: Shape): number {
  // error Function lacks ending return statement and return type does not include 'undefined'
  switch (s.kind) {
    case "square":
      return s.size * s.size;
    case "rectangle":
      return s.height * s.width;
    case "circle":
      return Math.PI * s.radius ** 2;
  }
}
```

这种方法简单，但是对旧代码支持不好，因为 strictNullChecks 这个配置项是 2.0 版本才加入的，如果你使用的是低于这个版本的，这个方法并不会有效。

### 使用 never 类型

当函数返回一个错误或者不可能有返回值的时候，返回值类型为 never。所以我们可以给 switch 添加一个 default 流程，当前面的 case 都不符合的时候，会执行 default 后的逻辑：

``` typescript
function assertNever(value: never): never {
  throw new Error("Unexpected object: " + value);
}

function getArea(s: Shape) {
  switch (s.kind) {
    case "square":
      return s.size * s.size;
    case "rectangle":
      return s.height * s.width;
    case "circle":
      return Math.PI * s.radius ** 2;
    default:
      return assertNever(s); // error 类型“Triangle”的参数不能赋给类型“never”的参数
  }
}
```

采用这种方式，需要定义一个的 asserNefer 函数，但是这种方式不仅能够在编译阶段提示我们遗漏了判断条件，而且在运行时也会报错。

### 注意

本文最后编辑于2019/07/05，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。