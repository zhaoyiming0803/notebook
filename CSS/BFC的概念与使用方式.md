### 什么是 BFC

Block Formatting Context（格式化上下文) 是 W3C CSS2.1 规范中的一个概念。它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用。

具有 BFC 特性的容器，其内部的元素不会在布局上影响到外面的元素，并且 BFC 具有普通容器所没有的一些特性。

### 具备 BFC 特性的元素

- body 根元素
- 浮动元素：float 除 none 以外的值
- 绝对定位元素：position (absolute、fixed)
- display 为 inline-block、table-cells、flex
- overflow 除了 visible 以外的值 (hidden、auto、scroll)

想一下，以上具有 BFC 特性的盒子，是不是『一个隔离了的独立容器，容器里边的元素不会在布局上影响到外面的元素』。

### BFC 特性的具体应用

1、同一个 BFC 下的两个子元素，它们的上下外边距会重叠

[https://github.com/zymfe/test-code/blob/master/test116.html](https://github.com/zymfe/test-code/blob/master/test116.html)

因为两个 div 元素都处于同一个 BFC 容器下 (body 元素) 所以第一个 div 的下边距和第二个 div 的上边距发生了重叠，所以两个盒子之间距离只有 100px，而不是 200px。

这不是 CSS 的 bug，如果想要避免外边距的重叠，可以将其放在不同的 BFC 容器中：

[https://github.com/zymfe/test-code/blob/master/test117.html](https://github.com/zymfe/test-code/blob/master/test117.html)

2、BFC 可以起到清除浮动的作用

容器内元素浮动，脱离了文档流，所以容器只剩下 2px 的边距高度（如果有边框的话）这种现象也叫『高度塌陷』。如果触发容器的 BFC，那么容器将会包裹着浮动元素。

[https://github.com/zymfe/test-code/blob/master/test118.html](https://github.com/zymfe/test-code/blob/master/test118.html)

3、BFC 可以阻止元素被浮动元素覆盖

[https://github.com/zymfe/test-code/blob/master/test119.html](https://github.com/zymfe/test-code/blob/master/test119.html)
