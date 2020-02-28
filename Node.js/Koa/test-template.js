const Koa = require('koa')
const Router = require('@koa/router')
const static = require('koa-static')
const router = new Router()
const app = new Koa()
const vm = require('vm')

const name = 'zhaoyining'
const templateMap = {
  templateA: '`<html><head></head><body><div>hello, ${name}, ${xss(include("templateB"))}<div></body></html>`',
  templateB: '`<p>welcome<script>alert("warning")</script></p>`'
}

const context = {
  name,
  include (name) {
    return templateMap[name]()
  },
  xss (str) {
    if (!str) return '';
    return str.toString()
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&quot;')
  }
}

Object.keys(templateMap).forEach(key => {
  const temp = templateMap[key]
  templateMap[key] = vm.runInNewContext(`() => ${temp}`, context)
})

app.use(static(__dirname + '/dist/'))

router.get('/test.html', async (ctx, next) => {
  console.log(222)
  ctx.body = templateMap.templateA()
})

app.use(router.routes(), router.allowedMethods)

app.listen(4000, () => {
  console.log('app listen at port 4000')
})