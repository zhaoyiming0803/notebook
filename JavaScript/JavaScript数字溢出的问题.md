今天在项目中遇到一个问题，用户登录之后，后端会返回用户 uid 和 token，uid 是数字，下次使用 uid 和 token 去请求接口的时候，后端返回用户不存在。把登录接口返回的 uid 和请求接口中带上的 uid 对比了下，是完全一样的，怎么会『用户不存在』呢？

网上搜索相关问题，最终确定是 uid 数字太大，导致溢出。

JS中整数的数字范围是 -2^53 ~ 2^53, 超出则视为 2^53 处理，但是溢出之后并不会报错，所以我们在使用巨型数字前没有意识到这个问题，意味着项目上线后，将可能丢失用户数据。

知道了问题所在，最后的解决办法就是：

1、后端将 uid 变为字符串存储，但是这个改动较大，牵扯到很多其他系统和 APP，不太好弄。

2、前端发送 HTTP 请求的时候，指定 Accept 为 text，后端返回数据之后，将数字 value 替换为字符串。

最终采用了第二种方法解决，代码如下：

``` javascript
// 从后端接收到的数据
var data = '{"uid":12345678901,"token":"sdf131o3ij1o"}';

// 使用正则，将匹配到的数字转为字符串
var parsedData = data.replace(/\"uid\"(\s+)?:(\s+)?(\d+)/g, '"uid:""$3"');

console.log(parsedData);
```

可以封装一个方法：

``` javascript
var data = '{"uid":12345678901,"token":"sdf131o3ij1o"}';

function num2str (data) {
  return data.replace(/(\"\w+\")(\s+)?:(\s+)?(\d+)/g, '$1:"$4"');
}

console.log(JSON.parse(num2str(data)));
```

