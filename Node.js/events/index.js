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