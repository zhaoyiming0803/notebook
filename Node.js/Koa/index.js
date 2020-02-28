const Koa = require('koa')
const Router = require('@koa/router')
const fs = require('fs')
const router = new Router()
const app = new Koa()
const static = require('koa-static')

app.use(static(__dirname + '/dist/'))

router.get('/index.html', async (ctx, next) => {
  ctx.body = fs.readFileSync(__dirname + '/dist/index.html', 'utf-8')
})

router.get('/list.html', async (ctx, next) => {
  ctx.body = fs.readFileSync(__dirname + '/dist/list.html', 'utf-8')
})

app.use(router.routes(), router.allowedMethods)

app.listen(3000)