// 观察者模式：
// 抛出一个事件，但是不知道是否有监听者
// 安全性不强，谁都能监听，只要监听了，发布消息之后就能知道消息
const EventEmitter = require('events').EventEmitter

class Person extends EventEmitter {
  constructor (name, age) {
    super();
    this.name = name
    this.age = age
  }
}

const p = new Person('zhaoyiming', 18)

p.on('message1', message => {
  console.log(message);
})

p.on('message2', message => {
  console.log(p);
})

p.emit('message1', [1, 2, 3])

p.emit('message2')