process.on('message', str => {
  console.log(str)
})

process.emit('message', 'ping')
