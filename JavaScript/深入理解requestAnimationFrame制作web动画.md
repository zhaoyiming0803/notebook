早就知道requestAnimationFrame在制作web动画方面有很多优势，但是具体有哪些优势，并且怎么使用，并不是很了解，今天正好抽时间在网上找资料学习下。

在Web应用中，实现动画效果的方法比较多，Javascript 中可以通过定时器 setTimeout 来实现，css3 可以使用 transition 和 animation 来实现，html5 中的 canvas 也可以实现。除此之外，html5 还提供一个专门用于请求动画的API，那就是 requestAnimationFrame，顾名思义就是请求动画帧。 为了深入理解 requestAnimationFrame 背后的原理，我们首先需要了解一下与之相关的几个概念：

### 一、屏幕刷新频率

即图像在屏幕上更新的速度，也即屏幕上的图像每秒钟出现的次数，它的单位是赫兹(Hz)。 对于一般笔记本电脑，这个频率大概是60Hz，可以在桌面上右键-&gt;屏幕分辨率-&gt;高级设置-&gt;监视器 中查看和设置。这个值的设定受屏幕分辨率、屏幕尺寸和显卡的影响，原则上设置成让眼睛看着舒适的值都行。

市面上常见的显示器有两种，即CRT和LCD， CRT就是传统显示器，LCD就是我们常说的液晶显示器。

CRT是一种使用阴极射线管的显示器，屏幕上的图形图像是由一个个因电子束击打而发光的荧光点组成，由于显像管内荧光粉受到电子束击打后发光的时间很短，所以电子束必须不断击打荧光粉使其持续发光。电子束每秒击打荧光粉的次数就是屏幕刷新频率。

而对于LCD来说，则不存在刷新频率的问题，它根本就不需要刷新。因为LCD中每个像素都在持续不断地发光，直到不发光的电压改变并被送到控制器中，所以LCD不会有电子束击打荧光粉而引起的闪烁现象。

因此，当你对着电脑屏幕什么也不做的情况下，显示器也会以每秒60次的频率正在不断的更新屏幕上的图像。为什么你感觉不到这个变化？ 那是因为人的眼睛有视觉停留效应，即前一副画面留在大脑的印象还没消失，紧接着后一副画面就跟上来了，这中间只间隔了16.7ms(1000/60&asymp;16.7)， 所以会让你误以为屏幕上的图像是静止不动的。而屏幕给你的这种感觉是对的，试想一下，如果刷新频率变成1次/秒，屏幕上的图像就会出现严重的闪烁，这样就很容易引起眼睛疲劳、酸痛和头晕目眩等症状。

### 二、动画原理

根据上面的原理我们知道，你眼前所看到图像正在以每秒60次的频率刷新，由于刷新频率很高，因此你感觉不到它在刷新。而动画本质就是要让人眼看到图像被刷新而引起变化的视觉效果，这个变化要以连贯的、平滑的方式进行过渡。 那怎么样才能做到这种效果呢？

刷新频率为60Hz的屏幕每16.7ms刷新一次，我们在屏幕每次刷新前，将图像的位置向左移动一个像素，即1px。这样一来，屏幕每次刷出来的图像位置都比前一个要差1px，因此你会看到图像在移动；由于我们人眼的视觉停留效应，当前位置的图像停留在大脑的印象还没消失，紧接着图像又被移到了下一个位置，因此你才会看到图像在流畅的移动，这就是视觉效果上形成的动画。

### 三、setTimeout

理解了上面的概念以后，我们不难发现，setTimeout 其实就是通过设置一个间隔时间来不断的改变图像的位置，从而达到动画效果的。但我们会发现，利用seTimeout实现的动画在某些低端机上会出现卡顿、抖动的现象。 这种现象的产生有两个原因：
	
1、setTimeout的执行时间并不是确定的。在Javascript中， setTimeout 任务被放进了异步队列中，只有当主线程上的任务执行完以后，才会去检查该队列里的任务是否需要开始执行，因此 setTimeout 的实际执行时间一般要比其设定的时间晚一些。

2、刷新频率受屏幕分辨率和屏幕尺寸的影响，因此不同设备的屏幕刷新频率可能会不同，而 setTimeout只能设置一个固定的时间间隔，这个时间不一定和屏幕的刷新时间相同。

以上两种情况都会导致setTimeout的执行步调和屏幕的刷新步调不一致，从而引起丢帧现象。 那为什么步调不一致就会引起丢帧呢？

首先要明白，setTimeout的执行只是在内存中对图像属性进行改变，这个变化必须要等到屏幕下次刷新时才会被更新到屏幕上。如果两者的步调不一致，就可能会导致中间某一帧的操作被跨越过去，而直接更新下一帧的图像。假设屏幕每隔16.7ms刷新一次，而setTimeout每隔10ms设置图像向左移动1px， 就会出现如下绘制过程：

第0ms: 屏幕未刷新，等待中，setTimeout也未执行，等待中；

第10ms: 屏幕未刷新，等待中，setTimeout开始执行并设置图像属性left=1px；

第16.7ms: 屏幕开始刷新，屏幕上的图像向左移动了1px， setTimeout 未执行，继续等待中；

第20ms: 屏幕未刷新，等待中，setTimeout开始执行并设置left=2px;

第30ms: 屏幕未刷新，等待中，setTimeout开始执行并设置left=3px;

第33.4ms:屏幕开始刷新，屏幕上的图像向左移动了3px， setTimeout未执行，继续等待中；

...

从上面的绘制过程中可以看出，屏幕没有更新left=2px的那一帧画面，图像直接从1px的位置跳到了3px的的位置，这就是丢帧现象，这种现象就会引起动画卡顿。

### 四、requestAnimationFrame

与setTimeout相比，requestAnimationFrame最大的优势是由系统来决定回调函数的执行时机。具体一点讲，如果屏幕刷新率是60Hz,那么回调函数就每1000/60=16.7ms被执行一次，如果刷新率是75Hz，那么这个时间间隔就变成了1000/75=13.3ms，换句话说就是，requestAnimationFrame的步伐跟着系统的刷新步伐走。它能保证回调函数在屏幕每一次的刷新间隔中只被执行一次，这样就不会引起丢帧现象，也不会导致动画出现卡顿的问题。

鉴于requestAnimationFrame在不同浏览器的支持程度，在使用的时候，我们可以使用代理模式进行优雅的降级，代码如下：

``` css
.container {
   width: 10px;
   height: 30px;
   background-color: red;
}
```

``` html
<div class="container" id="container"></div>
```

``` javascript
var container = document.querySelector('#container');
var width = 10;
var requestAnFr = (function () {
  return window.requestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    function (callback) {
      window.setTimeout(callback, 1000 / 60);
    };
})();

function animation () {
  if (width === 1000) {
    container = null;
    return;
  }
  width += 10;
  container.style.width = width + 'px';
  requestAnFr(animation);
}
animation();
```
其实requestAnimationFrame的实现原理就很明显了：

注册回调函数，浏览器更新时触发 animate，animate 会触发所有注册过的 callback，这里的工作机制可以理解为所有权的转移，把触发帧更新的时间所有权交给浏览器内核，与浏览器的更新保持同步。这样做既可以避免浏览器更新与动画帧更新的不同步，又可以给予浏览器足够大的优化空间。

### 五、使用requestAnimationFrame需要注意重复渲染的问题

requestAnimationFrame 不管理回调函数，这一点在w3c中有明确说明：

Also note that multiple calls to requestAnimationFrame with the same callback (before callbacks are invoked and the list is cleared) will result in multiple entries being in the list with that same callback, and thus will result in that callback being invoked more than once for the animation frame.&nbsp;

即在回调被执行前，多次调用带有同一回调函数的 requestAnimationFrame，会导致回调在同一帧中执行多次。我们可以通过一个简单的例子模拟在同一帧内多次调用 requestAnimationFrame 的场景：

``` javascript
const animation = timestamp => console.log('animation called at' + timestamp);
window.requestAnimationFrame(animation);
window.requestAnimationFrame(animation);
// animation called at 320.7559999991645
// animation called at 320.7559999991645
```
我们用连续调用两次 requestAnimationFrame 模拟在同一帧中调用两次 requestAnimationFrame。

例子中的 timestamp 是由 requestAnimationFrame 传给回调函数的，表示回调队列被触发的时间。由输出可知，animation 函数在同一帧内被执行了两次，即绘制了两次动画。然而在同一帧绘制两次动画很明显是多余的，相当于画了一幅画，然后再在这幅画上再画上同样的一幅画。

如何解决呢？

类似scroll、resize、mousemove这种高频发事件，一般的解决方法是使用节流函数。但是在这里使用节流函数并不能完美解决问题。因为节流函数是通过时间管理队列的，而 requestAnimationFrame 的触发时间是不固定的，在高刷新频率的显示屏上时间会小于 16.67ms，页面如果被推入后台，时间可能大于 16.67ms。

完美的解决方案是通过 requestAnimationFrame 来管理队列，其思路就是保证 requestAnimationFrame 的队列里，同样的回调函数只有一个。示意代码如下：

``` javascript
let scheduledAnimationFrame = false;
const onScroll = e =&gt; {
  if (scheduledAnimationFrame) return;
  scheduledAnimationFrame = true;
  window.requestAnimationFrame(timestamp =&gt; {
    scheduledAnimationFrame = false;
    animation(timestamp);
  })
}
window.addEventListener('scroll', onScroll);

```
requestAnimationFrame 不管理回调函数队列，而滚动、触摸这类高触发频率事件的回调可能会在同一帧内触发多次。所以正确使用 requestAnimationFrame 的姿势是，在同一帧内可能调用多次requestAnimationFrame 时，要管理回调函数，防止重复绘制动画。

本文涉及到的源码：

[https://github.com/zymseo/test-code/blob/master/test26.html](https://github.com/zymseo/test-code/blob/master/test26.html)

参考资料：

[深入理解requestAnimationFrame](http://web.jobbole.com/91578/)

[浅析requestAnimationFrame](http://web.jobbole.com/90625/?utm_source=blog.jobbole.com&amp;utm_medium=relatedPosts)

[HTML5探秘：用requestAnimationFrame优化web动画](http://www.webhek.com/post/requestanimationframe.html)

[requestAnimationFrame方法你真的用对了吗](https://segmentfault.com/a/1190000010229232)

[requestAnimationFrame，web中写动画的另一种选择](https://www.cnblogs.com/Wayou/p/requestAnimationFrame.html)

### 注意

本文最后编辑于2019/06/11，技术更替飞快，文中部分内容可能已经过时，如有疑问，可在线提issue。