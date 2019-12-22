[减少DNS解析时间及网络性能优化](https://zhidao.baidu.com/question/1928266222718087627.html)

[前端基础篇之HTTP协议](https://mp.weixin.qq.com/s/naI6cwBvhpljI4jVf93F6g)

[Web通信中传统轮询、长轮询和WebSocket简介](https://zhuanlan.zhihu.com/p/25690011)

[TCP和UDP的区别](https://zhuanlan.zhihu.com/p/24860273)

[TCP/IP协议及三次握手、四次断开详解](https://zhuanlan.zhihu.com/p/82458458)

[HTTPS加密过程和TLS证书验证](https://juejin.im/post/5a4f4884518825732b19a3ce)

[为什么HTTPS比HTTP更安全?](https://mp.weixin.qq.com/s/waGPiuMSQu7YyC8Zd7qsJg)

[详解Https是如何确保安全的？](http://www.codeceo.com/article/https-make-safe.html)

[HTTP协议入门](http://www.ruanyifeng.com/blog/2016/08/http.html)

[HTTP1.0、HTTP1.1 和 HTTP2.0 的区别](https://juejin.im/entry/5981c5df518825359a2b9476)

[在浏览器地址栏输入URL，按下回车后究竟发生了什么？](https://www.jianshu.com/p/69c2cf84b407)

[从URL输入到页面展现到底发生什么？](https://mp.weixin.qq.com/s/TAttTiNbea9qzBHR07RPyQ)

[web安全之XSS,CSRF](https://www.jianshu.com/p/64f60ce328b9)

[GET和POST的异同](https://www.oschina.net/news/77354/http-get-post-different)

另外，GET 请求可以被缓存，多次 GET 同一个地址（参数也相同），只会发起一次请求，例如：后台管理系统经常会用到的搜索功能。

[http2多路复用和http1 keep-alive的区别](https://www.nihaoshijie.com.cn/index.php/archives/698/)

http2 多路复用主要解决了 http1 请求阻塞的问题：http2 以 stream 的方式发送请求，可同时发送多个请求，server 端可以根据 stream 的唯一标识来响应对应的请求。而 http1 的后续请求想要复用当前连接就必须等到前一个完成才行。

### HTTP 常用请求头及具体含义

Accept：浏览器可接受的 MIME 类型。

Accept-Charset：浏览器可接受的字符集。

Accept-Encoding：浏览器能够进行解码的数据编码方式，比如 gzip。

Accept-Language：浏览器所希望的语言种类，当服务器能够提供一种以上的语言版本时要用到。

If-Modified-Since: 文件最后更改时间

Connection：表示是否需要持久连接。如果Servlet看到这里的值为“Keep-Alive”，或者看到请求使用的是HTTP 1.1（HTTP 1.1默认进行持久连接），它就可以利用持久连接的优点，当页面包含多个元素时（例如Applet，图片），显著地减少下载所需要的时间。要实现这一点，Servlet需要在应答中发送一个Content-Length头，最简单的实现方法是：先把内容写入ByteArrayOutputStream，然后在正式写出内容之前计算它的大小。

Content-Length：表示请求消息正文的长度。

Cookie：设置cookie,这是最重要的请求头信息之一

Host：接受请求的服务器地址，可以是 IP 端口号，也可以是域名

Referer：包含一个URL，用户从该URL代表的页面出发访问当前请求的页面。

User-Agent：浏览器类型，如果Servlet返回的内容与浏览器类型有关则该值非常有用。

### HTTP 常用响应头及具体含义

Server 服务器应用程序的软件名称和版本

Content-Type 响应正文的类型（是图片还是二进制字符串）

Content-Length 响应正文长度

Content-Charset 响应正文使用的数据压缩格式

Content-Language 响应正文使用的语言

Cache-Control 强缓存相关设置

Content-Encoding: 文件编码方式

If-Modified-Since：协商缓存相关设置，文件最后修改时间

ETag: 协商缓存相关设置，根据文件内容生成的 tag 值，用于判断当前文件是否有更新

[如何优雅的谈论HTTP](https://www.jianshu.com/p/52d86558ca57)