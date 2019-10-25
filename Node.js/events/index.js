const EventEmitter = require('events').EventEmitter;

class Person extends EventEmitter {
  constructor () {
    super();
  }
}

const p = new Person();

p.on('message', message => {
  console.log(message);
});

p.emit('message', [1, 2, 3]);