const cluster = require('cluster')
const os = require('os')

const pingPongMap = {}

function startPingPong (worker) {
  const task = pingPongMap[worker.process.pid] = {
    count: 0,
    worker,
    timer: null
  }

  task.timer = setInterval(() => {
    if (task.count >= 3) {
      clearInterval(task.timer)
      task.timer = null
      process.kill(task.worker)
    } else {
      console.log('ping')
      task.worker.send('ping')
    }
  }, 3000)

  task.worker.on('message', str => {
    if (str === 'pong') {
      console.log('pong')
      task.count -= 1
    }
  })
}

function stopPingPong (worker) {
  const task = pingPongMap[worker.process.pid]
  clearInterval(task.timer)
  delete pingPongMap[worker.process.pid]
}

if (cluster.isMaster) {
  for (let i = 0; i < Math.floor(os.cpus().length / 2); i++) {
    const worker = cluster.fork()
    startPingPong(worker)
  }

  cluster.on('exit', (worker, code, signal) => {
    console.log(`工作进程 ${ worker.process.pid } 已退出, code: ${ code }, signal: ${ signal }`)
    stopPingPong(worker)
    // n秒之后自动复活一个挂掉的进程
    // 但还是应该上报，检查一下问题到底出在哪里？
    // 如果真是代码问题，就应该立即修复，否则重启一个进程之后，照样还会挂
    // setTimeout 后重启一个进程，并不是万全之策
    setTimeout(() => {
      const worker = cluster.fork()
      startPingPong(worker)
    }, 5000)
  });
} else {
  require('./child')
}
