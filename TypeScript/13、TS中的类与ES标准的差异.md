### 基础

在 TS 中定义类：

``` typescript
class Point {
  x: number;
  y: number;

  constructor (x: number, y: number) {
    this.x = x;
    this.y = y;
  }

  getPositon () {
    return `${this.x}, ${this.y}`;
  }
}
const point = new Point(1, 2);
```
我们首先在定义类的代码块的顶部定义两个实例属性，并且制定类型为 number。构造函数 constructor 需要传入两个参数，都是 number 类型，并且把这两个参数分别赋值给两个实例属性。最后定义了一个定义在类的原型对象上的方法 getPosition。

同样也可以使用继承来复用一些特性：

``` typescript
class Parent {
  name: string;
  constructor (name: string) {
    this.name = name;
  }
}
class Child extends Parent {
  constructor (name: string) {
    super(name);
  }
}
```
以上这些和 ES6 标准中的类没什么区别。

### 修饰符

在 ES6 标准类的定义中，默认情况下，定义在实例的属性和方法会在创建实例后添加到实例上。而如果时定义在类里没有定义在 this 上的方法，实例可以继承这个方法。而如果使用 static 修饰符定义的属性和方法，是静态属性和静态方法，实例是没法访问和集成到的。我们还通过一些手段，实现了私有方法，但私有属性的实现还不好实现。

接下来看下 TS 中的公共、私有和受保护的修饰符：

1、public

public 表示公共的，用来指定在创建实例后可以通过实例访问订单，也就是类定义的外部可以访问的属性和方法。默认是 public，但是 TSLint 可能会要求你必须用修饰符来表明这个属性或方法是什么类型的。

``` typescript
class Point {
  public x: number;
  public y: number;
  constructor (x: number, y: number) {
    this.x = x;
    this.y = y;
  }
  public getPosition () {
    return `${this.x}, ${this.y}`;
  }
}
```

2、private

private 修饰符表示私有的，它修饰的属性在累的定义外面是没法访问的：

``` typescript
class Parent {
  private age: number;
  constructor(age: number) {
    this.age = age;
  }
}
const p = new Parent(18);
console.log(p);
console.log(p.age); // Property 'age' is private and only accessible within class 'Parent'.
console.log(Parent.age); // Property 'age' does not exist on type 'typeof Parent'.

class Child extends Parent {
  constructor(age: number) {
    super(age);
    // Only public and protected methods of the base class are accessible via the 'super' keyword.
    console.log(super.age);
  }
}
```
从以上代码可以看到， age 属性使用 private 修饰符修饰，说明它是私有属性，我们打印创建的实例对象 p，发现它是有属性 age的，但是视图访问 p 的 age 属性时，编译器会报错，告诉我们私有属性只能在 Parent 中访问。

这里我们需要说下 super.age 的报错，在 ES6 的类中，super 作为对象代表着不同的含义，这里在 constructor 访问的 super 相当于父类本身，这里我们看到使用 private 修饰的属性，在子类中时没法访问的。

3、protected

protected 修饰符是受保护修饰符，和 private 有些相似，但有一点不同，protected 修饰的成员在继承该类的子类中可以访问：

``` typescript
class Parent {
  protected age: number;
  constructor(age: number) {
    this.age = age;
  }
}

class Child extends Parent {
  constructor(age: number) {
    super(age);
  }
  public getAge() {
    return this.age;
  }
}

const c = new Child(19);
// Property 'age' is protected and only accessible within class 'Parent' and its subclasses.
//console.log(c.age);

console.log(c.getAge()); // 19
```

protected 还能用来修饰 constructor 构造函数，加了 protected 修饰符之后，这个类就不能再用来创建实例，只能被子类继承。在 ES6 中需要用 new.target 自行判断，而 TS 则只需用 protected 修饰符即可：

``` typescript
class Parent {
  protected constructor () {}
}
// Constructor of class 'Parent' is protected and only accessible within the class declaration.
const p = new Parent();

class Child extends Parent {
  constructor() {
    super();
  }
}

const c = new Child();
```

### readonly 修饰符

在类里可以使用 readonly 关键字将属性设置为只读。

``` typescript
class UserInfo {
  readonly name: string;
  constructor (name: string) {
    this.name = name;
  }
}
const user = new UserInfo('zhaoyiming');
// Cannot assign to 'name' because it is a read-only property.
user.name = 'zhangsan';
```

### 参数属性

之前的例子中，我们都是在类的定义的顶部初始化实例属性，在 constructor 里接收参数然后对实例属性进行赋值，可以使用 参数属性 来简化这个过程。参数属性简单来说就是在 constructor 构造函数的参数前面加上访问限定赋，也就是 public、private、protected、readonly 中的任意一个：

``` typescript
class A {
  constructor (name: string) {}
}
const a = new A('zhangsan');
// Property 'name' does not exist on type 'A'.
console.log(a.name);

class B {
  constructor (public: name: string) {}
}
const b = new B('lisi');
console.log(b.name); // lisi
```
可以看到，在定义类 B 时，构造函数有一个参数 name，这个 name 使用访问修饰符 public 修饰，此时即为 name 声明了参数属性，也就无需再显示的在类中初始化这个属性了。

### 静态属性

和 ES6 中的类一样，在 TS 中一样使用 static 关键字来指定属性或方法是静态的，实例将不会添加这个静态属性，也不会继承这个静态方法，可以用 static 关键字来指定一个静态属性或静态方法：

``` typescript
class Parent {
  public static age: number = 18;
  public static getAge () {
    return Parent.age;
  }
  constructor () {}
}
const p = new Parent();
// Property 'age' is a static member of type 'Parent'
console.log(p.age);
console.log(Parent.age); // 18
```
如果使用了 private 修饰，道理和之前的一样：

``` typescript
class Parent {
  public static getAge() {
    return Parent.age;
  }
  private static age: number = 18;
  constructor() { }
}

const p = new Parent();

// Property 'age' is a static member of type 'Parent'
console.log(p.age);

// Property 'age' is private and only accessible within class 'Parent'
console.log(Parent.age);

console.log(Parent.getAge()); // 18
```

### 可选类属性

TS 在 2.0 版本，支持可选类属性，也是使用 ？符号来标记：

``` typescript
class Info {
  name: string;
  age?: number;
  constructor (name: string, age?: number, public sex?: string) {
    this.name = name;
    this.age = age;
  }
}
const info1 = new Info('zhaoyiming');
const info2 = new Info('zhaoyiming', 18);
const info3 = new Info('zhaoyiming', 18, 'man');
```

### 存取器

这个也就是 ES6 标准中的存值函数和取值函数，也就是在设置属性值时调用的函数，和在访问属性值的时候调用的函数，用法和写法和 ES6 的没有区别：

``` typescript
class Person {
  constructor(public name: string) {

  }

  get uname() {
    console.log('getter');
    return this.name;
  }

  set uname(value) {
    console.log('setter');
    this.name = value;
  }
}

const p = new Person('zhaoyiming');
p.uname = 'zhangsan';
console.log(p.uname);
```

### 抽象类

抽象类一般用来被其他类继承，而不直接用它创建实例。抽象类和类内部定义抽象方法，使用 abstract 关键字：

``` typescript
abstract class People {
  constructor(public name: string) { }
  abstract printName(): void
}

class Man extends People {
  constructor(name: string) {
    super(name);
    this.name = name;
  }
  printName() {
    console.log(this.name);
  }
}

const m = new Man('zhaoyiming');
m.printName();

// Cannot create an instance of an abstract class.
const p = new People('haha');
```

使用 abstract 关键字定义一个抽象方法 printName，这个定义可以指定参数，指定参数类型，指定返回类型。当我们直接使用抽象类 People 实例化的时候，就会报错，我们只能创建一个继承抽象类的子类，使用子类来实例化。

抽象类中定义的抽象方法，在子类中是不会被继承的，所以在子类中必须实现该方法的定义。

2.0版本开始，abstract 关键字不仅可以标记类和类里面的方法，还可以标记类中定义的属性和存取器。

``` typescript
abstract class People {
  abstract _name: string;
  abstract get insideName(): string;
  abstract set insideName(value: string): void;
}

class Pp extends People {
  _name: string;
  insideName: string
}
```

#### 抽象方法和抽象存取器都不能包含实际的代码块

### 实例类型

当我们定义一个类，并创建实例后，这个实例的类型就是创建它的类：

``` typescript
class People {
  constructor (public name: string) {}
}
let p: People = new People('zhangsan');
```
当然了，创建实例的时候指定 p 的类型为 People 并不是必须的，TS 会推断出它的类型。虽然指定了类型，但是当我们再定义一个和 People 类同样实现的类 Animal，并且创建实例赋值给 p 的时候，是没有问题的：

``` typescript
class Animal {
  constructor (public name: string) {}
}
const p = new Animal('haha');
```
#### 所以，如果想实现对创建实例的类的判断，还是需要用到 instanceof 关键字。

### 类类型接口

使用接口可以强制一个类的定义必须包含某些内容：

``` typescript
interface FoodInterface {
  type: string
}

class FoodClass implements FoodInterface {
  // Class 'FoodClass' incorrectly implements interface 'FoodInterface'.
  // Property 'type' is missing in type 'FoodClass' but required in type 'FoodInterface'.
  static type: string;
  constructor () {}
}

// 这样是没问题的
class FoodClass implements FoodInterface {
  constructor(public type: string) { }
}
```

上面的接口 FoodInterface 要求使用该接口的值必须有一个 type 属性，定义的类 FoodClass 要使用接口，需要使用关键字 implements。implements 关键字用来指定一个类要继承的接口，如果是接口和接口、类和类直接的继承，使用 extends，如果是类继承接口，则用 implements。

有一点需要注意，接口监测的是使用该接口定义的类创建的实例，所以上面例子中虽然定义了静态属性 type，但静态属性不会添加到实例上，所以还是报错。

### 接口继承类

接口可以继承一个类，当接口继承该类之后，会继承类的成员，但是不包括其实现，也就是只继承成员以及成员类型。接口还会继承类的 private 和 protected 修饰的成员，当接口继承的这个类中包含这两个修饰符修饰的成员时，这个接口只能被这个类或它的子类实现。

``` typescript
class A {
  constructor(protected name: string) { }
}

// Interface 'I' incorrectly extends interface 'A'.
// Property 'name' is protected but type 'I' is not a class derived from 'A'.
interface I extends A {
  name: string
}

// Property 'name' is protected but type 'I' is not a class derived from 'A'.
class B implements I {
  constructor(public name: string) { }
}
```

以上代码会报错，如果将 A 改成下面这样，就正常了：

``` typescript
class A {
  constructor(public name: string) { }
}
```

### 注意

本文最后编辑于2019/07/03，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。