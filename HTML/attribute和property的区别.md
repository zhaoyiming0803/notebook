## attribute 和 property 的区别

### 什么是 property

JavaScript DOM 对象具有属性。这些属性类似于特定元素的实例变量。因此，属性可以是不同的类型（布尔型、字符串等）。

``` javascript
<a href='page2.html' class='link classes' name='linkName' id='linkID'>Hi</a>

$('#linkID').prop('href'); // returns "http://example.com/page2.html"
$('#linkID').prop('name'); // returns "linkName"
$('#linkID').prop('id'); // returns "linkID"
$('#linkID').prop('className'); // returns "link classes"
```
正如你所看到的，我们在 HTML 元素中设置的所有属性都可以通过 prop 访问到，其他属性也是访问的，比如 style，即使我们没有明确的设置过它们。

属性也可以通过 prop 方法更新：

``` javascript
<a href='page2.html'>Hi</a>

$('#linkID').prop('href', 'page1.html');
$('#linkID').prop('href'); // returns "http://example.com/page1.html"
```

### 什么是 attribute

attrubute 在 HTML 元素上，而不是 DOM，它与 property 是很类似的。当 property 可用时，推荐使用 property 而不是 attribute。

attribute 值只能是字符串，不是能其他类型。

``` javascript
<input type="checkbox" checked="true"/>

$('input').prop('checked'); // returns true
$('input').attr('checked'); // returns "checked"
```

如果元素具有默认值，则即使该值已更改，属性也会显示默认值。

``` javascript
<input type="text" name="username" value="user123" />

$('input').prop('value', '456user');
$('input').prop('value'); // returns "456user"
$('input').attr('value'); // returns "user123"
```

Attributes can be useful when you want to set a custom attribute, that is, when there is no property associated.

可以使用 attrubute 设置自定义属性：

``` javascript
<input type="text" />
$('input').attr('customAttribute', 'something custom');
$('input').attr('customAttribute'); // returns "something custom"
$('input').prop('customAttribute'); // returns undefined
```
不过，也可以自定义 property，不过不推荐这么做：

``` javascript
<input type="text" />
$('input').prop('customAttribute', 'something custom');
$('input').prop('customAttribute'); // returns "something custom"
$('input').attr('customAttribute'); // returns undefined
```

参考：

[JS: attribute vs. property](https://lucybain.com/blog/2014/attribute-vs-property/)

[.prop() vs .attr()](https://stackoverflow.com/questions/5874652/prop-vs-attr/5884994#5884994)

[HTML: The difference between attribute and property](http://jquery-howto.blogspot.com/2011/06/html-difference-between-attribute-and.html)