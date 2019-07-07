TypeScript 开发环境搭建，以 VsCode 为例：

1、安装 EditorConfig for VS Code 插件

2、在项目根目录下创建 .vscode 文件夹，然后在这个文件夹内创建 settings.json 文件，内容如下：

``` json
{
  "tslint.configFile": "./tslint.json",
  "tslint.autoFixOnSave": true,
  "editor.formatOnSave": true
}
```

tslint.configFile 用来指定 tslint.json 文件的路径，这里这里是相对根目录的。

tslint.autoFixOnSave 设置为 true，则每次保存的时候编辑器会自动根据我们的 tslint 配置对不符合规范的代码进行自动修改。

tslint.formatOnSave 设为 true，则编辑器会对格式在保存的时候进行整理。

3、安装 node 、npm

4、全局安装 tslint：npm install tslint -g

5、全局安装 TypeScript：npm install typescript -g

6、创建一个项目目录，如：learn-typescript，进入项目目录，执行命令：tsc --init

这时项目根目录多了一个 tsconfig.json 文件，里边有很多内容。json文件中可以使用 // 和 /**/注释，这个是 TS 在 1.8 版本支持的，后面的笔记会学到。

tsconfig.json 中默认有4项没有注释的配置，其中有一个 lib 配置项，它是一个数组，用来配置需要引入的声明库文件，我们后面会学到 ES6 语法和 DOM 相关内容，所以需要引入两个声明库文件，需要在这个数组中添加『es6』和『dom』，也就是修改数组为["dom", "es6"]，其他配置暂时不用修改。

7、然后还需要在项目中安装 typescript，因为我们要搭配使用 webpack 进行编译和本地开发，不是使用tsc命令：npm install typescript

8、配置 tslint，全局安装 tslint：npm install tslint -g，然后在项目根目录下，使用 tslint 初始化配置文件：tslint -i，运行结束时候，项目根目录下多了一个 tslint.json文件，其中包括以下几个字段：

``` json
{
  "defaultSeverity": "error",
  "extends": [
    "tslint:recommended"
  ],
  "jsRules": {},
  "rules": {},
  "rulesDirectory": []
}
```

defaultSeverity 是提醒级别，如果为 error 则会报错，如果为 warning 则会警告，如果设为 off 则关闭，那 TSlint 就关闭了。

extends 可指定集成指定的预设配置规则

jsRules 用来配置对 js 和 jsx 文件的校验，配置规则的方法和下面的 rules 一样

rules 是重点了，我们要让 TSLint 根据怎样的规则来检查代码，比如当我们不允许代码中使用 eval 方法时，就要在这里配置 "no-eval": true

rulesDirectory 可以指定规则配置文件，这里指定相对路径

参考：

[TSLint配置说明](https://palantir.github.io/tslint/usage/configuration/)

[TSLint规则说明](https://palantir.github.io/tslint/rules/)

最后就是安装 webpack 并配置 webpack，这个就很熟悉了，代码可参考项目：[learn-typescript](https://github.com/zymfe/learn-typescript)

### 注意

本文最后编辑于2019/06/25，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。