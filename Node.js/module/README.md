### Node.js如何解析模块？

Node中，每个文件模块都是一个对象，它的定义如下：

``` javascript
function Module(id, parent) {
  this.id = id;
  this.exports = {};
  this.parent = parent;
  this.filename = null;
  this.loaded = false;
  this.children = [];
}

module.exports = Module;

var module = new Module(filename, parent);
```

所有的模块都是 Module 的实例。可以看到，当前模块（module.js）也是 Module 的一个实例。

在Node.js里导入是通过require函数调用进行的。 Node.js会根据require的是相对路径还是非相对路径做出不同的行为。

相对路径很简单。 例如，假设有一个文件路径为/root/src/moduleA.js，包含了一个导入var x = require("./moduleB"); Node.js以下面的顺序解析这个导入：

1、将/root/src/moduleB.js视为文件，检查是否存在。

2、将/root/src/moduleB视为目录，检查是否它包含package.json文件并且其指定了一个"main"模块。 在我们的例子里，如果Node.js发现文件/root/src/moduleB/package.json包含了{ "main": "lib/mainModule.js" }，那么Node.js会引用/root/src/moduleB/lib/mainModule.js。

3、将/root/src/moduleB视为目录，检查它是否包含index.js文件。 这个文件会被隐式地当作那个文件夹下的”main”模块。

但是，非相对模块名的解析是个完全不同的过程。 Node会在一个特殊的文件夹node_modules里查找你的模块。 node_modules可能与当前文件在同一级目录下，或者在上层目录里。 Node会向上级目录遍历，查找每个node_modules直到它找到要加载的模块。写 require 的时候，vscode 会有提示。

还是用上面例子，但假设/root/src/moduleA.js里使用的是非相对路径导入var x = require("moduleB");。 Node则会以下面的顺序去解析moduleB，直到有一个匹配上。

1、/root/src/node_modules/moduleB.js

2、/root/src/node_modules/moduleB/package.json (如果指定了"main"属性)

3、/root/src/node_modules/moduleB/index.js 

4、/root/node_modules/moduleB.js

5、/root/node_modules/moduleB/package.json (如果指定了"main"属性)

6、/root/node_modules/moduleB/index.js 

7、/node_modules/moduleB.js

8、/node_modules/moduleB/package.json (如果指定了"main"属性)

9、/node_modules/moduleB/index.js

注意Node.js在步骤（4）和（7）会向上跳一级目录。