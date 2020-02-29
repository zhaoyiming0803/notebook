const cluster = require('cluster')
const os = require('os')

if (cluster.isMaster) {
  console.log('master')
  for (let i = 0; i < Math.floor(os.cpus().length / 2); i++) {
    const worker = cluster.fork()
    worker.on('message', data => {
      console.log('count from child process: ', data)
    })
  }
} else {
  console.log('child')
  require('./child')
}
