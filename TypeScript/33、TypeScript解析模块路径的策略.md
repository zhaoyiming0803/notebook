TypeScript是模仿Node.js运行时的解析策略来在编译阶段定位模块定义文件。 因此，TypeScript在Node解析逻辑基础上增加了TypeScript源文件的扩展名（.ts，.tsx和.d.ts）。 同时，TypeScript在package.json里使用字段"types"来表示类似"main"的意义 - 编译器会使用它来找到要使用的”main”定义文件。

参考：《[node.js解析模块的策略](https://github.com/zymfe/learn-nodejs/tree/master/src/module)》

比如，有一个导入语句import { b } from "./moduleB" 在 /root/src/moduleA.ts 里，会以下面的流程来定位"./moduleB"：

1、/root/src/moduleB.ts

2、/root/src/moduleB.tsx

3、/root/src/moduleB.d.ts

4、/root/src/moduleB/package.json (如果指定了"types"属性)

5、/root/src/moduleB/index.ts

6、/root/src/moduleB/index.tsx

7、/root/src/moduleB/index.d.ts

回想一下Node.js先查找moduleB.js文件，然后是合适的package.json，再之后是index.js。

类似地，非相对的导入会遵循Node.js的解析逻辑，首先查找文件，然后是合适的文件夹。 因此/root/src/moduleA.ts文件里的import { b } from "moduleB"会以下面的查找顺序解析：

1、/root/src/node_modules/moduleB.ts

2、/root/src/node_modules/moduleB.tsx

3、/root/src/node_modules/moduleB.d.ts

4、/root/src/node_modules/moduleB/package.json (如果指定了"types"属性)

5、/root/src/node_modules/moduleB/index.ts

6、/root/src/node_modules/moduleB/index.tsx

7、/root/src/node_modules/moduleB/index.d.ts 

8、/root/node_modules/moduleB.ts

9、/root/node_modules/moduleB.tsx

10、/root/node_modules/moduleB.d.ts

11、/root/node_modules/moduleB/package.json (如果指定了"types"属性)

12、/root/node_modules/moduleB/index.ts

13、/root/node_modules/moduleB/index.tsx

14、/root/node_modules/moduleB/index.d.ts 

15、/node_modules/moduleB.ts

16、/node_modules/moduleB.tsx

17、/node_modules/moduleB.d.ts

18、/node_modules/moduleB/package.json (如果指定了"types"属性)

19、/node_modules/moduleB/index.ts

20、/node_modules/moduleB/index.tsx

21、/node_modules/moduleB/index.d.ts

TypeScript只是在步骤（8）和（15）向上跳了两次目录。 这并不比Node.js里的流程复杂。程序执行起来会很快。

更多参考：https://typescript.bootcss.com/module-resolution.html

