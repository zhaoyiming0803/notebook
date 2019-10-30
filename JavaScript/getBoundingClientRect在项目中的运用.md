学会 getBoundingClientRect 的用法之后，发现之前用『[元素偏移量+定位父级+滚动距离](https://github.com/zymfe/notebook/blob/master/JavaScript/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3%E5%AE%9A%E4%BD%8D%E7%88%B6%E7%BA%A7offsetParent%E5%8F%8A%E5%81%8F%E7%A7%BB%E5%A4%A7%E5%B0%8F.md)』的方式手动计算一个盒子是否在可视区域内，真是太麻烦了。

不管怎么样，先把笔记记下来，方便后期回顾。

### getBoundingClientRect 基本概念

1、getBoundingClientRect 用于获得页面中某个元素的『上』、『右』、『下』、『左』分别相对浏览器视窗的位置。

2、getBoundingClientRect 是 DOM 元素到浏览器可视范围的距离（不包含文档卷起的部分）。

``` javascript
var { top, right, bottom, left, width, height } = el.getBoundingClientRect();
```

top、left 分别是元素距离浏览器视窗上边、左边的距离，width、height 是元素自身的宽高。

right 是指元素右边界距窗口最左边的距离，bottom 是指元素下边界距窗口最上面的距离。

### 判断元素是否在可视区域内

源代码：《[判断某个元素是否在可视区域内](https://github.com/zymfe/test-code/blob/master/test102.html)》
