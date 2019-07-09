TS 在 3.0 版本新增了顶级类型 unknown。它相对于 any 来说是安全的。

### 任何类型的值都可以赋给 unknown 类型

``` typescript
let value: unknown;
value = 'a';
value = 123;
```

### 如果没有类型断言或基于控制流的类型细化时，unknown 不可以赋值给其他类型，此时它只能赋值给 unknown 和 any 类型

``` typescript
let value1: unknown;
let value2: string = value1; // error 不能将类型 unknown 分配给类型 string
value1 = value2;
```

### 如果没有类型断言或基于控制流的类型细化，则不能在它上面进行任何操作

``` typescript
let value: unknown;
value += 1; // error 对象的类型为 unknown
```

### unknown 与任何其他类型组成的交叉类型，最后都等于其他类型

``` typescript
type type1 = unknown && string; // type1 => string
type type2 = number && unknown; // type2 => number
type type3 = unknown && unknown; // type3 => unknown
type type4 = unknown && string[]; // type4 = string[]
```
### unknown 与任何其他类型组成的联合类型，都等于 unkknown 类型，但只有 any 例外，unknown 与 any 组成的联合类型等于 any

``` typescript
type type5 = string | unknown; // type5 => unknown
type type6 = any | unknown; // type6 => any
type type7 = number[] | unknown; // type7 => unknown
```
### never 类型是 unknown 的子类型

``` typescript
type type8 = never extends unknown ? true : false; // type8 => true
```

### keyof unknown 等于类型 never

``` typescript
type type9 = keyof unknown; // type9 => never
```

### 注意

本文最后编辑于2019/07/09，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。