const fs = require('fs')
const protocolBuffers = require('protocol-buffers')
const schema = protocolBuffers(fs.readFileSync('./description.proto'), 'utf-8')

const person = {
  name: 'zhaoyiming',
  sex: 'man',
  age: 18
}

const column = {
  id: 1,
  name: 'Node.js',
  price: 10
}

const personBuffer = schema.Person.encode(person)
console.log('personBuffer: ', personBuffer)
const personJson = schema.Person.decode(personBuffer)
console.log('personJson: ', personJson)

const columnBuffer = schema.Column.encode(column)
console.log('columnBuffer: ', columnBuffer)
const columnJson = schema.Column.decode(columnBuffer)
console.log('columnJson: ', columnJson)
