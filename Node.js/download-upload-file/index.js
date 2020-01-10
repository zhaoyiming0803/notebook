const request = require('request')
const fs = require('fs')
const http = require('http')
const { put } = require(`${process.cwd()}/ali-oss`);

const urls = [
  'http://cdn.haoyiku.com.cn/assets/img/2020/01/02/n_1577951807016_3729___size750x934.jpg',
  'http://cdn.haoyiku.com.cn/assets/img/2020/01/02/n_1577951824396_8443___size800x800.jpg',
  'http://cdn.haoyiku.com.cn/assets/img/2020/01/06/n_1578277737714_6372___size800x800.jpg',
  'http://cdn.haoyiku.com.cn/assets/img/2019/11/06/n_1573029253477_1575___size550x550.jpeg'
]

console.time('handler')

async function download (url) {
  const timestamp = Date.now()
  const filename = `${ process.cwd() }/${ timestamp }.jpg`
  return new Promise((resolve, reject) => {
    request(url).pipe(fs.createWriteStream(filename)).on('close', () => resolve(filename))
  })
}

function createUrlsPromises (urls) {
  return urls.map(url => {
    return new Promise(async (resolve, reject) => {
      const filename = await download(url)
      const res = await put(filename)
      resolve(res)
    })
  })
}

Promise.all(createUrlsPromises(urls)).then(res => {
  console.log(res)
  console.timeEnd('handler')
})


// var req = http.get(url, function (res) {
//   var imgData = "";
//   res.setEncoding("binary"); // 一定要设置response的编码为binary否则会下载下来的图片打不开
//   res.on("data", function (chunk) {
//     imgData += chunk;
//   });
//   res.on("end", function () {
//     fs.writeFile(`${ process.cwd() }/download.jpg`, imgData, "binary", function (err) {
//       if (err) {
//         console.log("保存失败");
//       }
//       console.log("保存成功");
//     });
//   });
//   res.on("error", function (err) {
//     console.log("请求失败");
//   });
// });

// req.on('error', function (err) {
//   console.log("请求失败2" + err.message);
// });