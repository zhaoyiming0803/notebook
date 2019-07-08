在 JS 中，this 可以用来获取全局对象，类实例对象、构造函数实例等的引用，在 TS 中，this 也是一种类型，先来看个计算器 Counter 的例子：

``` typescript
class Counter {
  constructor (public count: number = 0) {
    
  }

  add (value: number) {
    this.count += value;
    return this;
  }

  subtract (value: number) {
    this.count -= value;
    return this;
  }
}

const counter = new Counter(10);
console.log(counter.count); // 10;
conter.add(5).subtract(2);
console.log(counter.count); // 13
```

我们给 Counter 类定义几个方法，每个方法都返回 this，这个 this 即指向实例，这样我们就可以通过链式调用的形式来使用这些方法。但是如果我们要通过继承的形式丰富这个 Coounter 类，添加一些方法，依然返回 this，然后采用链式调用的形式调用，在过去版本的 TS 中是有问题的，先来看下继承的逻辑：

``` typescript
class PowCounter extends Counter {
  constructor (public count: number = 0) {
    super(count);
  }

  pow (value: number) {
    this.count = this.count ** value;
    return this;
  }
}

const powCounter = new PowCounter(2);
powCounter.pow(3).subtract(3).add(1);
console.log(powCounter.counter); // 6
```

以上代码中，实例 powCounter 上调用继承来的 subtract 和 add 方法，如果是在过去，就会报错，因为创建实例 powCounter 的类 PowCounter 没有定义这两个方法，所以会报没有这两个方法的错误。但是在 1.7 版本中增加了 this 类型，TS 会对方法返回的 this 进行判断，就不会报错了。

对于对象来说，对象的属性值可以是一个函数，那么这个函数也称为方法，在方法内如果访问 this，默认情况下是对这个对象的引用，this 类型也就是这个对象的字面量类型，如下：

``` typescript
// 例：3.7.1
const info = {
  name: 'zhaoyiming',
  getName () {
    // 这里的 this 类型为 {name: string; getName(): string;}
    return this.name;
  }
}
```

但是如果显式的指定了 this 的类型，那么 this 的类型就改变了，如下：

``` typescript
// 例：3.7.2
const info = {
  name: 'zhaoyiming',
  getName (this: {age: number}) {
    this; // 这里的 this 类型为 {age: number}
  }
}
```

如果我们在 tsconfig.json 里将 nolmplicitThis 设为 true，这时候有两种不同的情况：

1、对象字面量具有 ThisType<T> 指定的类型，此时 this 的类型为 T：

``` typescript
// 使用类型别名定义一个接口，这里用了泛型，两个泛型变量 D 和 M
type ObjectDescriptor<D, M> = {
  // 指定 data 为可选字段，类型为 D
  data?: D;
  // 指定 methods 为可选字段，类型为 M 和 ThisType<D & M> 组成的交叉类型
  // ThisType 是一个内置的接口，用来在对象字面量中键入 this，这里指定 this 的类型为 D & M
  methods?: m & ThisType<D & M>;
}

// 这里定义一个 mackObject 函数，参数 desc 的类型为 ObjectDescriptor<D, M>
function makeObject<D, M>(desc: ObjectDescriptor<D, M>): D & M {
  let data: object = desc.data || {};
  let methods: object = desc.methods || {};
  // 这里通过 ... 操作符，将 data 和 methods 里所有的属性、方法都放到了同一个对象里返回，这个对象类型自然就是 D & M，因为它同时包含 D 和 M 两个类型的字段
  return { ...data, ...methods } as D & M;
}

let obj = makeObject({
  // 这里 data 的类型就是我们上面定义的 ObjectDescriptor<D, M> 类型中的 D
  data: { x: 0, y: 0 },
  // 这里 methods 的类型就是我们上面定义 ObjectDescriptor<D, M>类型中的 M
  methods: {
    moveBy (dx: number, dy: number) {
      // 所以这里的 this 是我们通过 ThisType<D & M>指定的，this 的类型就是 D & M
      this.x += dx;
      this.x += dy;
    }
  }
});

obj.x = 10;
obj.y = 20;
obj.moveBy(5, 5);
```

2、不包含 ThisType<T> 指定的上下文类型，那么此时 this 具有上下文类型，也就是普通的情况。我们可以试着把上面使用了 ThisType<T> 的例子中，ObjectDescriptor<D, M>类型中指定 methods 的类型中的 & ThisType<D & M> 去掉，你会发现 moveBy 方法中 this.x 和 this.y 报错了，因为此时 this 的类型是 methods 这个对象字面量的类型。

### 注意

本文最后编辑于2019/07/08，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。