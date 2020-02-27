; (function () {

  return

  var p = new Promise(function (resolve, reject) {
    setTimeout(function () {
      reject(new Error('cry'))
    })
  })

  // Promise 最终 reject 之后，如果没有通过 catch 捕获
  // 最后错误回抛到全局
  // p.catch(function (res) {
  //   console.log(res)
  // })

})();

; (function () {
return
  const Promise = require('./MyPromise')

  var p = new Promise((resolve, reject) => {
    setTimeout(() => {
      // resolve('success')
      reject('fail')
    }, 1000)
  })

  p.then(res => {
    console.log('resolve1: ', res)
    throw new Error('fail')
  }).catch(res => {
    console.log('catch1: ', res)
  })

  var p1 = p.catch(res => {
    console.log('catch2: ', res)
    return 2
  })

  p1.then(res => {
    console.log('resolve2-1: ', res)
  }).then(res => {
    console.log('resolve2-2: ', res)
  })

  p.catch(res => {
    console.log('catch3: ', res)
    return 3
  }).then(res => {
    console.log('resolve3: ', res)
  })

})();

;(function () {

  const Promise = require('./MyPromise')

  var p = new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(false)
    }, 1000)
  })

  // p.then(res => {
  //   console.log('then: ', res)
  // }).catch(res => {
  //   console.log('catch: ', res)
  // })

  // p.then(res => {
  //   console.log('then: ', res)
  // }).then(undefined, res => {
  //   console.log('catch: ', res)
  // })

  p.then(res => {
    console.log('then1: ', res)
    // return 123
  }).then(res => {
    console.log('then2: ', res)
  })

})()
