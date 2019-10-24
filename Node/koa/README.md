### Koa 简介

官网介绍：Koa 是一个新的 web 框架，由 Express 幕后的原班人马打造， 致力于成为 web 应用和 API 开发领域中的一个更小、更富有表现力、更健壮的基石。 通过利用 async 函数，Koa 帮你丢弃回调函数，并有力地增强错误处理。 Koa 并没有捆绑任何中间件， 而是提供了一套优雅的方法，帮助您快速而愉快地编写服务端应用程序。

其中有几个关键字：更小、更富有表现力、更健壮、错误处理、中间件、快速。

用过 Express，再来用 Koa，肯定会有以上几点感受。

优秀的作品，总是忍不住想通过源码看看它是怎么实现的。

### 从 require('koa') 开始看 Koa 源码

``` javascript
const Koa = require('koa');
```
在 Node.js 里导入是通过 require 函数调用进行的。 Node.js 会根据 require 的是相对路径还是非相对路径做出不同的行为。

require('koa') 是非相对路径，Node.js 会在一个特殊的文件夹 node_modules 里查找你的模块。node_modules 可能与当前文件在同一级目录下，或者在上层目录里。 Node.js 会向上级目录遍历，查找每个 node_modules 直到它找到要加载的模块。写 require 的时候，vscode 会有提示。

在项目的 node_modules 目录下找到 koa 目录，首先看 package.json，找到 main 字段：

``` json
{
  "main": "lib/application.js"
}
```
main 字段对应的是 Koa 的入口文件。lib 目录下只有4个文件，这也是 Koa 的所有源码。相比 Express 『更小』。

找到入口文件就好办了。

### new Koa() 发生了什么

实例化一个 Koa 对象来使用 Koa 对外提供的各种 API。

``` javascript
const app = new Koa();
```

在 application.js 中找到 Application 类，看其 constructor 构造函数，了解其初始化过程。

``` javascript
// ... 省略一些 require
const Emitter = require('events');

// Application 继承了 events，也就有了事件发布订阅的功能
// Koa 错误处理功能就是以此为基础
module.exports = class Application extends Emitter {
  constructor(options) {
    super();
    options = options || {};
    this.proxy = options.proxy || false;
    this.subdomainOffset = options.subdomainOffset || 2;
    this.env = options.env || process.env.NODE_ENV || 'development';
    if (options.keys) this.keys = options.keys;

    // 很重要：初始化 middleware 中间件数组
    this.middleware = [];

    // 很重要：初始化 context、request、response 三个属性，它们与 middleware 共同组成了 Koa 最核心的部分
    this.context = Object.create(context);
    this.request = Object.create(request);
    this.response = Object.create(response);

    if (util.inspect.custom) {
      this[util.inspect.custom] = this.inspect;
    }
  }
}
```
Koa 实例化完成之后，我们会使用以下方法正式创建一个应用，让它具有处理请求和响应的能力。

``` javascript
app.use(async function (ctx, next) {
  // ...
  await next();
  // ...
});

// ... 或许还需要使用很多的 use 方法

app.listen(3000, '127.0.0.1', error => {
  console.log('app started at port 3000...');
});
```
use 方法：
``` javascript
module.exports = class Application extends Emitter {
  use(fn) {
    // 规定 use 方法的参数必须是一个 function
    if (typeof fn !== 'function') throw new TypeError('middleware must be a function!');

    // Koa1.x 是用 generator 函数来操作异步流程的，Koa2在这里做了兼容，并将在 V3 版本中彻底弃用。
    if (isGeneratorFunction(fn)) {
      deprecate('Support for generators will be removed in v3. ' +
                'See the documentation for examples of how to convert old middleware ' +
                'https://github.com/koajs/koa/blob/master/docs/migration.md');
      // 将 generator 形式的函数转换成 async 形式。
      // https://www.npmjs.com/package/koa-convert
      fn = convert(fn);
    }
    debug('use %s', fn._name || fn.name || '-');
    // 将回调函数添加到中间件队列中
    this.middleware.push(fn);
    return this;
  }
}
```
listen 方法：

``` javascript
module.exports = class Application extends Emitter {
  listen(...args) {
    debug('listen');
    // 下面两段代码很熟悉了，使用 Node.js 创建一个 HTTP 服务
    // this.callback 方法就是每次接收到 HTTP 请求之后的具体操作
    const server = http.createServer(this.callback());
    return server.listen(...args);
  }
}
```

callback 方法：

``` javascript
module.exports = class Application extends Emitter {
  callback() {
    // 使用 compose 方法预处理 middleware：https://www.npmjs.com/package/koa-compose
    // 首先判断 compose 方法的入参是不是数组，如果不是，则 throw new TypeError('Middleware stack must be an array!')
    // 接着使用 for of 循环，判断数组的每一项是不是 function，如果不是，则 throw new TypeError('Middleware must be composed of functions!')
    // 最后返回一个 function，这个 function 是 Koa 中间件执行流程的核心，后面会记录。
    const fn = compose(this.middleware);

    // 因为 Application 类继承了 events，所以也有 listenerCount 方法
    // 用来判断开发者是否有监听 error，如果没有的话，Koa 会内置一个，并执行自定义的 onerror 方法
    // 当错误发生时，console.log 一些信息
    if (!this.listenerCount('error')) this.on('error', this.onerror);

    // http.createServer 的入参是一个方法，有两个入参，即 req、res
    const handleRequest = (req, res) => {
      // 使用 createContext 将 req 和 res 包装成一个 ctx 上下文对象
      const ctx = this.createContext(req, res);
      // 正式处理接收到的 HTTP 请求
      return this.handleRequest(ctx, fn);
    };

    return handleRequest;
  }
}
```
先来看下 createContext 做了哪些事情？
``` javascript
module.exports = class Application extends Emitter {
  createContext(req, res) {
    // 代码很清晰，就是在 context 对象上挂载了一些属性，然后返回
    // context 的初始内容，可参考 lib/context.js 文件
    // 做一个 demo，收到请求后，把 context 打印出来，结合代码看，就都清楚了
    const context = Object.create(this.context);
    const request = context.request = Object.create(this.request);
    const response = context.response = Object.create(this.response);
    context.app = request.app = response.app = this;
    context.req = request.req = response.req = req;
    context.res = request.res = response.res = res;
    request.ctx = response.ctx = context;
    request.response = response;
    response.request = request;
    context.originalUrl = request.originalUrl = req.url;
    context.state = {};
    return context;
  }
}
```
再来看 handleRequest 方法：
``` javascript
module.exports = class Application extends Emitter {
  handleRequest(ctx, fnMiddleware) {
    const res = ctx.res;
    res.statusCode = 404;
    const onerror = err => ctx.onerror(err);
    const handleResponse = () => respond(ctx);
    // onFinish 方法是通过引入 on-finished 包得到的
    // 主要作用是：当 HTTP 请求 closes、finishes 或 errors 时执行回调
    // https://www.npmjs.com/package/on-finished
    // 执行的 onerror 方法，可参考 context.js 文件中的 onerror 方法，主要通过 emit 触发 error 事件，最后 res.end(msg) 返回错误信息
    onFinished(res, onerror);
    // fnMiddleware 就是上面通过 compose 组合之后的一系列 middleware，下面重点叙述
    return fnMiddleware(ctx).then(handleResponse).catch(onerror);
  }
}
```

compose 方法：

``` javascript
// https://github.com/koajs/compose/blob/master/index.js
function compose (middleware) {
  // 上面笔记记录过的判断一个中间件是否符合规范的逻辑
  if (!Array.isArray(middleware)) throw new TypeError('Middleware stack must be an array!')
  for (const fn of middleware) {
    if (typeof fn !== 'function') throw new TypeError('Middleware must be composed of functions!')
  }

  // compose 最后返回的方法，即 handleRequest 中执行的 fnMiddleware 方法。
  return function (context, next) {
    // last called middleware #
    let index = -1
    return dispatch(0)
    function dispatch (i) {
      if (i <= index) return Promise.reject(new Error('next() called multiple times'))
      index = i
      let fn = middleware[i]
      if (i === middleware.length) fn = next
      // 每个中间件是一个 async 函数，被上一个中间件的 next 方法调用（首个除外）
      if (!fn) return Promise.resolve()
      try {
        // 执行 next 方法，起始就是再次执行 dispatch，只是传入的 index + 1，表示执行下一个中间件
        return Promise.resolve(fn(context, dispatch.bind(null, i + 1)));
      } catch (err) {
        return Promise.reject(err)
      }
    }
  }
}
```
Koa 使用 compose 组合之后的一系列中间件来处理 HTTP 的 request 和 response，而 compose 的实现原理很像是一个『洋葱模型』：

![洋葱模型](https://user-gold-cdn.xitu.io/2019/3/5/1694be78986ad1c5?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

具体过程是：

- 一个请求到一旦到后端，就开始接触洋葱的最外层。

- 遇到一个 next()，就进入下一层。不过值得提醒的是，异步函数的 next() 与同步函数的 next(),不是在同一个空间的，我们可以假想一个“异步空间栈”，后入先出。

- 什么时候到洋葱中心？就是遇到的第一个没有next的中间件,或者遇到一个中间件报错，就会把这个中间件当成中心，因为遇到错误了，不会再继续往里面走。这个时候，就开始向洋葱的外层开始走了。如果第一个中间件就没有 next，直接返回的。那么就不存在洋葱模型。

- 一层一层外面走的时候，就先走位所有的同步中间件，再依次走“异步空间栈”的中间件。

有没有一种『递归』的感觉。

之前模拟实现了上述 compose 方法，可参考：https://github.com/zymfe/test-code/blob/master/test93.js

整体流程就是这样，Koa 的核心就是提供了一套简单的中间件（一些自定义方法）使用方法，可以拦截、处理 HTTP 请求和响应，方便我们处理业务。

request.js 和 response.js 没有重点说，它们是在 createContext 方法被添加了一些新的属性，原有属性和方法可以参考对应文件中的代码，就是一些设置、读取请求头、请求体的方法和属性等。
