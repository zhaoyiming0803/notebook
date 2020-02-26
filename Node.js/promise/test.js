;(function () {

  var p = new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(1)
    })
  })

  p.then(res => {
    console.log(res)
  }).then(res => {
    console.log(res)
  })

  console.log(Promise.all)

})();