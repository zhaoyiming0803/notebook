const vm = require('vm')
const name = 'zhaoyiming'
const str = '`hello, my name is ${name}`'
const content = vm.runInNewContext(str, { name })

console.log(content)