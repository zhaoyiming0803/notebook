TypeScript 是 JavaScript 的超集，JavaScript 能做的，TypeScript 也能做，并且解决了 JavaScript 的很多痛点，如弱类型。

TypeScript 始终紧跟 ECMAScript 标准，所以 ES6/7/8/9 等新语法标准都是支持的，而且在语言层面上，TypeScript 对某些语法做了拓展，比如新增枚举（Enum）这种在一些语言中常见的数据类型，对 Class 实现了一些 ES6 标准中没有确定的语法标准等等。

ES6/7/8/9 代码需要借助 babel 将代码编译为 ES5，才能被浏览器『安全的』运行，但是 TypeScript 不需要借助 babel 编译，它有自己的编译方式。

『人如其名』，TypeScript 最大的特点就是『我们可以使用强类型语法来编写JavaScript代码』，JavaScript 运行的时候才能暴露错误，如：

1、访问了一个对象没有的属性，报错：xxx is undefined

2、调用函数却少传了某些参数，但是函数内部却有使用，报错：xxx is undefined

3、函数返回值是字符串，但开发者却把它当做数字来使用，如：'10' + 1 = '101'，其实我们想要的结果是 10 + 1 = 11

......

以上问题，在 TypeScript 中都能很好的解决。

TypeScript 配合 TSlint，在团队开发中保证大家的代码风格都是一致的，这一点与 ESlint 类似。

### 注意

本文最后编辑于2019/06/25，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。