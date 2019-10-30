经常有这样的需求：当盒子在页面可视区域内时候，才去执行网络加载，也就是我们常说的懒加载。

要实现这类需求，就得先理解『偏移量』（offset dimension）的概念。涉及到偏移量的主要是4个属性：offsetTop、offsetLeft、offsetWidth、offsetHeight，以及一个偏移参照：offsetParent 定位父级。

### 定位父级

offsetParent 并不叫『偏移父级』，而是叫『定位父级』，顾名思义，它与『定位』紧密联系。

定位父级 offsetParent 的定义是：与当前元素最近的经过定位(position 不等于 static)的父级元素，包括：

1、元素自身有 fixed 定位，offsetParent 的结果为null

当元素自身有 fixed 固定定位时，我们知道固定定位的元素相对于视口进行定位，此时没有定位父级，offsetParent 的结果为 null。

2、元素自身无 fixed 定位，且父级元素都未经过定位，offsetParent 的结果为 body 元素。

3、元素自身无fixed定位，且父级元素存在经过定位的元素，offsetParent 的结果为离自身元素最近的经过定位的父级元素。

4、如果自身无定位，所有的父级元素也无定位，那么其 offsetParent 是 body。

5、body 元素的 ofsetParent 为 null。

### 偏移量

元素盒子的偏移量是相对于其定位父级的，用一张图来表示：

![偏移量](https://images2015.cnblogs.com/blog/740839/201609/740839-20160901091826449-1099471755.jpg)

1、offsetWidth

表示元素在水平方向上占用的空间大小，无单位(以像素px计)。

2、offsetHeight

表示元素在垂直方向上占用的空间大小，无单位(以像素px计)。

3、offsetTop

表示元素的上外边框至 offsetParent 元素的上内边框之间的像素距离。

4、offsetLeft

表示元素的左外边框至 offsetParent 元素的左内边框之间的像素距离。

源代码：《[判断某个元素是否在可视区域内](https://github.com/zymfe/test-code/blob/master/test101.html)》

### 注意事项

1、所有偏移量属性都是只读的。

2、如果给元素设置了 display: none，则它的偏移量属性都为0。

3、每次访问偏移量属性都需要重新计算，会耗费大量的性能，所以可以根据实际情况，将各偏移量保存为变量，避免重复计算。

### 注意

本文最后编辑于2019/10/30，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。