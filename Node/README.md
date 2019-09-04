## 使用 PM2 线上部署 Node 应用

### 安装 node 和 npm

首先在 node 官网 找到 linux 版本的下载链接

在 linux 服务器上输入命令：

wget https://nodejs.org/dist/v10.16.2/node-v10.16.2-linux-x64.tar.gz

解压：

tar xvzf node-v10.16.2-linux-x64.tar.gz

把下载好的node文件从根目录移到 /opt/node 下（可以根据自己爱好移动也可忽略此操作）：

mv /node-v10.16.2-linux-x64 /opt/node/

把 node 和npm 设置为全局：

我们需要创建 node 和 npm  两个软链接到  /usr/local/bin 目录下（要获取root部分权限的话在 ln 前面加 sudo）

ln -s /opt/node/node-v10.16.2-linux-x64/bin/node /usr/local/bin/node
 
ln -s /opt/node/node-v10.16.2-linux-x64/bin/npm /usr/local/bin/npm

注意：创建完软链后最好分别进 /usr/local/bin 下的node 和npm 目录看下 如果文件出现红色闪烁则说明在创建软链前的路径不对导致找不到目录，仔细检查node的路径。

上述步骤完成后 在任意目录下 node -v ，npm -v 看是否显示版本号，未显示则证明安装不成功，仔细检查步骤有没有错！

### 安装全局 pm2

npm install -g pm2 （或者npm install pm2@latest -g 安装最新版本的pm2 模快）

设为全局，创建软链：

ln -s /opt/node/node-v10.16.2-linux-x64/lib/node_modules/pm2/bin/pm2 /usr/local/bin

创建完后 用 pm2 list 测试一下吧!

### 开发一个小应用

在需要用 node 运行的项目目录安装 express，并新建 index.js 内容如下：

``` javascript
var express = require('express');
var app = express();

app.get('/api/test', function (req, res) {
  res.json({
    code: 0,
    data: { status: 200 },
    msg: 'success'
  });
});
 
app.listen(8081);
console.log("node start on port of 8081");
```

### 通过 PM2 构建 Node

在项目目录下新建 pm2.json

``` json
{
	"apps": [
		{
			"name": "my-application",
			"script": "./index.js",
			"watch": false,
			"node_args": "--harmony",
			"merge_logs": false,
			"cwd": "./",
			"instance": 1,
			"exec_mode": "cluster"
		}
	]
}
```
运行：pm2 start pm2.json

### 使用 nginx 转发端口

``` conf
http {
  server {
    listen       80;
    server_name  example.com;

    location / {
        proxy_pass http://127.0.0.1:8081;
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Allow-Headers Content-Type;
        add_header Access-Control-Allow-Methods POST;
        add_header Access-Control-Allow-Methods GET;
    }
  }
}
```

重启 nginx 之后，打开浏览器输入地址 https://example.com/api/test ， 看是不是输出结果了。
