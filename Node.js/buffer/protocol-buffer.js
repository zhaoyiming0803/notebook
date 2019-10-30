const fs = require('fs');
const protocolBuffer = require('protocol-buffers');
const personProto = fs.readFileSync('./description.proto', 'utf-8');

const data = {
  name: 'zhaoyiming',
  age: 18,
  sex: 'man'
};

const schema = protocolBuffer(personProto);

console.log(schema);

const personBuffer = schema.Person.encode(data);
console.log(personBuffer);

const personData = schema.Person.decode(personBuffer)
console.log(personData);