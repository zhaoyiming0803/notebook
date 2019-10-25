require('./check-versions')()

var config = require('../config')
if (!process.env.NODE_ENV) {
  process.env.NODE_ENV = JSON.parse(config.dev.env.NODE_ENV)
}

var opn = require('opn');
var path = require('path');
var express = require('express');
var webpack = require('webpack');
var proxyMiddleware = require('http-proxy-middleware');
var webpackConfig = require('./webpack.dev.conf');

function resolve (dir) {
  return path.join(__dirname, '..', dir);
}

// default port where dev server listens for incoming traffic
var port = process.env.PORT || config.dev.port
// automatically open browser, if not set will be false
var autoOpenBrowser = !!config.dev.autoOpenBrowser
// Define HTTP proxies to your custom API backend
// https://github.com/chimurai/http-proxy-middleware
var proxyTable = config.dev.proxyTable

var app = express();
var compiler = webpack(webpackConfig)

var devMiddleware = require('webpack-dev-middleware')(compiler, {
  publicPath: webpackConfig.output.publicPath,
  quiet: true
})

var hotMiddleware = require('webpack-hot-middleware')(compiler, {
  log: false,
  heartbeat: 2000
})
// force page reload when html-webpack-plugin template changes
// 临时注销，启动node服务端时开启
// compiler.plugin('compilation', function (compilation) {
//   compilation.plugin('html-webpack-plugin-after-emit', function (data, cb) {
//     hotMiddleware.publish({ action: 'reload' })
//     cb()
//   })
// })

// proxy api requests
Object.keys(proxyTable).forEach(function (context) {
  var options = proxyTable[context]
  if (typeof options === 'string') {
    options = { target: options }
  }
  app.use(proxyMiddleware(options.filter || context, options))
})

// handle fallback for HTML5 history API
app.use(require('connect-history-api-fallback')())

// serve webpack bundle output
app.use(devMiddleware)

// enable hot-reload and state-preserving
// 热更新
app.use(hotMiddleware)

// serve pure static assets
var staticPath = path.posix.join(config.dev.assetsPublicPath, config.dev.assetsSubDirectory)
app.use(staticPath, express.static('./static'));

/*
* 自己新增 开始 
*/
// let bodyParse = require('body-parser'); // 接收post数据

app.set('views', '../'); // 设置前端模板录
app.set('view engine', 'html'); // 设置前端模板文件类型
// app.use(bodyParse.json()); // 用来接收post提交的json数据
// app.use(bodyParse.urlencoded({extended:true})); // 也可以接收任何数据类型的数据，包括文本、视频、图片等
// app.use(require('../server/index')); // 加载路由
/*
* 自己新增 结束
*/

var _resolve;
var readyPromise = new Promise(resolve => {
  _resolve = resolve
})

var server;
var https = require('https');
var portfinder = require('portfinder');
var fs = require('fs');
portfinder.basePort = port;

devMiddleware.waitUntilValid(() => {
  portfinder.getPort((err, port) => {
    if (err) {
      console.log(err)
      _reject(err)
    }
    process.env.PORT = port
    var uri = 'https://www.example.com:' + port
    console.log('> Listening at ' + uri + '\n')

    // when env is testing, don't need open it
    if (autoOpenBrowser && process.env.NODE_ENV !== 'testing') {
      opn(uri)
    }

    const options = {
      key: fs.readFileSync(resolve('./ssl/key.pem')),
      cert: fs.readFileSync(resolve('./ssl/crt.pem'))
    }

    server = https.createServer(options, app).listen(port)
    _resolve()
  })
})

module.exports = {
  ready: readyPromise,
  close: () => {
    server.close()
  }
}
