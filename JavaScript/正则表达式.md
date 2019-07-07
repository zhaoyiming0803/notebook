###  什么是正则表达式？

正则表达式(regular expression)描述了一种字符串匹配的模式，可以用来检查一个字符串是否含有某种子串、将匹配的子串做替换或者从某个字符串中取出符合某个条件的子串等。其实正则表达式就是处理字符串的，我们可以用它来处理一些复杂的字符串。

如下两种方式，找出字符串中的所有数字：

``` javascript
var str = 'abd123oi909i9Wowej8';
```

1、使用循环遍历字符串，逐个判断：

``` javascript
function findNumByLoop (str) {
  var tmp = '';
  var arr = [];
  for (var i = 0, len = str.length; i <= len; i += 1) {
    var cur = str[i];
    if (!isNaN(cur)) {
      tmp += cur;
    } else {
      if (tmp) {
        arr.push(tmp);
      }
      tmp = '';
    }
  }
  return arr;
}
console.log(findNumByLoop(str));
```

2、使用正则表达式：

``` javascript
function findNumByReg () {
  var reg = /\d+/g;
  var match = '';
  var arr = [];
  while ((match = reg.exec(str))) {
    arr.push(match[0]);
  }
  return arr;
}
console.log(findNumByReg(str));
```

### 正则表达式的创建方式：

1、字面量创建：

``` javascript
var reg = /\d+/;
```

2、实例创建：

``` javascript
var reg = new RegExp(/\d+/, 'img')
```

构造函数 RegExp 的第一个参数就是正则表达式，第二个参数是修饰符：

i 忽略大小写匹配

m 多行匹配，即在到达一行文本末尾时还会继续寻常下一行中是否与正则匹配的项

g 全局匹配 模式应用于所有字符串，而非在找到第一个匹配项时停止

### 字面量创建方式和构造函数创建方式的区别

1、字面量创建方式不能进行字符串拼接，实例创建方式可以：

``` javascript
var regParam = 'cm';
var reg1 = new RegExp(regParam + '1');
var reg2 = /regParam/;
console.log(reg1);    //   /cm1/
console.log(reg2);    //  /regParam/
```

2、字面量创建方式特殊含义的字符不需要转义，实例创建方式需要转义：

``` javascript
var reg1 = new RegExp('\d');  //  /d/ 
var reg2 = new RegExp('\\d')  //  /\d/
var reg3 = /\d/;              //  /\d/
```

###  元字符

参考 W3C 手册：《[JavaScript RegExp 对象](http://www.w3school.com.cn/jsref/jsref_obj_regexp.asp)》。

大概总结下：

1、代表特殊含义的元字符：

\d : 0-9之间的任意一个数字  \d只占一个位置

\w : 数字，字母 ，下划线 0-9 a-z A-Z _

\s : 空格或者空白等

\D : 除了\d

\W : 除了\w

\S : 除了\s

 . : 除了\n之外的任意一个字符

 \ : 转义字符

 | : 或者

() : 分组

\n : 匹配换行符

\b : 匹配边界：字符串的开头和结尾 空格的两边都是边界 => 不占用字符串位数

 ^ : 限定开始位置 => 本身不占位置

 $ : 限定结束位置 => 本身不占位置

[a-z] : 任意字母 []中的表示任意一个都可以

[^a-z] : 非字母 []中^代表除了

[abc] : abc三个字母中的任何一个 [^abc]除了这三个字母中的任何一个字符

2、代表次数的量词元字符：

\* : 0到多个

\+ : 1到多个

? : 0次或1次 可有可无

{n} : 正好n次；

{n,} : n到多次

{n, m} : n次到m次

### 元字符的具体使用实例

### 量词出现在元字符后面 如 \d+ ，限定出现在前面的元字符的次数：

``` javascript
var str = '1223334444';
var reg = /\d{2}/g;
var res = str.match(reg);
console.log(res);           // ["12", "23", "33", "44", "44"]

var str ='  我是空格君  ';
var reg = /^\s+|\s+$/g;     // 匹配开头结尾空格
var res = str.replace(reg,'');
console.log('('+res+')');   // (我是空格君)
```

### 正则中的 [] ：

一般 [] 中的字符没有特殊含义，如 + 就表示 + ，但是像 \w 这样的还是有特殊含义的：

``` javascript
var str1 = 'abc';
var str2 = 'dbc';
var str3 = '.bc';
var reg = /[ab.]bc/;    // 此时的 . 就表示 .
reg.test(str1);         // true
reg.test(str2);         // false
reg.test(str3);         // true
```

[] 中，不会出现两位数：

``` javascript
// [12] 表示 1 或者 2，不过 [0-9] 这样的表示 0 到 9，[a-z] 表示 a 到 z
// 例如：匹配从 18 到 65 年龄段所有的人

var reg = /[18-65]/; // 这样写对么
reg.test('50');
// 以上正则会报错：
// Uncaught SyntaxError: Invalid regular expression: /[18-65]/: Range out of order in character class
// 聪明的你想可能是 8-6 这里不对，于是改成 [16-85] 似乎可以匹配 16 到 85 的年龄段的，但实际上发现这也是不靠谱的

// 实际上我们匹配这个 18-65 年龄段的正则我们要拆开来匹配
// 我们拆成3部分来匹配 18-19  20-59 60-65 
reg = /(18|19)|([2-5]\d)|(6[0-5])/;
```

### () 的提高优先级功能：凡是有 | 出现的时候，我们一定要注意是否有必要加上 () 来提高优先级；

1、只要正则中出现了小括号那么就会形成一份分组：

``` javascript
var reg = /hello(\s\w+)/g;
var str = 'hello world';

str.replace(reg, function ($0, $1, $2, $3) {
  console.log($0); // hello world
  console.log($1); //  world
  console.log($2); // 0
  console.log($3); // hello world
});
```

以上 $2 就是 () 子表达式匹配到的字符串

参考 W3C 文档：《[JavaScript replace() 方法](http://www.w3school.com.cn/jsref/jsref_replace.asp)》。

2、重复子项：只要在正则中出现了括号就会形成一个分组，我们可以通过 \n (n是数字代表的是第几个分组)来引用这个分组，第一个小分组我们可以用 \1 来表示，就是第一个小括号内的值（从左向→）, \1+ 表示重复上面捕获组里的内容一次或多次

组的下标从 0 开始，下标为 0 的组就是整个表达式。下标为 1 的组就是从左到右开始的第一个左括号所对应的值，下标为 2 的组就是从左向右第二个左括号对应的值，以此类推，比如：((A)(B)C)D

\\0 ((A)(B)C)D

\\1 ((A)(B)C)

\\2 (A)

\\3 (B)

例如：求出这个字符串 'abAAbcBCCccdaACBDDabcccddddaab' 中出现最多的字母，并求出出现多少次（忽略大小写）：

（1）使用循环遍历的方式：

``` javascript
function findItemByLoop (str) {
  var obj = {};
  for (var i = 0, len = str.length; i < len; i += 1) {
    var cur = str[i].toLowerCase();
    if (obj[cur] === undefined) {
        obj[cur] = 1;
    } else {
        obj[cur] += 1;
    }
  }

  var arr = [];
  for (var prop in obj) {
    var tmp = {};
    tmp[prop] = tmp.num = obj[prop];
    tmp.key = prop;
    arr.push(tmp);
  }

  function compare (a, b) {
    return a.num > b.num
      ? -1
      : a.num < b.num
        ? 1
        : 0;
  }

  arr.sort(compare);

  return '出现最多的字母是：' + arr[0].key + '，共出现了：' + arr[0].num + '次';
}

var res = findItemByLoop(str);
console.log(res);
```

（2）使用正则：

``` javascript
function findItemByReg (str) {
  function compare (a, b) {
    return a.localeCompare(b);
  }

  str = str
    .toLowerCase()
    .split('')
    .sort(compare)
    .join('');

  var reg = /(\w)\1+/ig;
  var maxStr = '';
  var maxLen = 0;
  str.replace(reg, function($0, $1, $2, $3){
    console.log('$0:', $0);
    console.log('$1:', $1);
    console.log('$2:', $2);
    console.log('$3:', $3);
    var regLen = $0.length;
    if (regLen > maxLen) {
      maxLen = regLen;
      maxStr = $1;
    }
  });
  return '出现最多的字母是：' + maxStr + '，共出现了：' + maxLen + '次';
}

var res = findItemByReg(str);
console.log(res);
```

### 当我们加 () 只是为了提高优先级而不想捕获小分组时，可以在 () 中加 ?: 来取消分组的捕获

``` javascript
var str = 'aaabbb';
var reg = /(a+)(?:b+)/;
var res = reg.exec(str);
//只捕获第一个小分组的内容
console.log(res); // ["aaabbb", "aaa", index: 0, input: "aaabbb"]
```

``` javascript
var str = 'aaabbb';
var reg = /(a+)(b+)/;
var res = reg.exec(str);
// 捕获了全部2个小分组的内容
console.log(res); // ["aaabbb", "aaa", "bbb", index: 0, input: "aaabbb"]
```

### 正则运算符的优先级

1、正则表达式从左到右进行计算，并遵循优先级顺序，这与算术表达式非常类似。

2、相同优先级的会从左到右进行运算，不同优先级的运算先高后低。

下面是常见的运算符的优先级排列，依次从最高到最低说明各种正则表达式运算符的优先级顺序：

\                           => 转义符

(), (?:), (?=), []          => 圆括号和方括号

*, +, ?, {n}, {n,}, {n,m}   => 量词限定符

^, $, \任何元字符、任何字符    => 以某个字符开头、结尾或转义

|                           => 替换，"或" 操作

字符具有高于替换运算符的优先级，一般用 | 的时候，为了提高 | 的优先级，我们常用()来提高优先级，如： 匹配 food 或者 foot 的时候 reg = /foo(t|d)/ 这样来匹配.

### 正则的特性

1、贪婪性：

所谓的贪婪性就是正则在捕获时，每一次会尽可能多的去捕获符合条件的内容。如果我们想尽可能的少的去捕获符合条件的字符串的话，可以在量词元字符后加 ? 。

2、懒惰性：

懒惰性则是正则在成功捕获一次后不管后边的字符串有没有符合条件的都不再捕获。如果想捕获目标中所有符合条件的字符串的话，我们可以用标识符 g 来标明是全局捕获。

``` javascript
var str = '123aaa456';
```

``` javascript
var reg = /\d+/;  // 只捕获一次,一次尽可能多的捕获
var res = str.match(reg)
console.log(res); // ["123", index: 0, input: "123aaa456"]
```

``` javascript
var reg = /\d+/g; // 多次捕获，每次尽可能多的捕获
var res = str.match(reg)
console.log(res); // ["123", "456"]
```

``` javascript
var reg = /\d+?/g;    // 解决贪婪性、懒惰性
var res = str.match(reg)
console.log(res); // ["1", "2", "3", "4", "5", "6"]
```

### 和正则相关的一些方法

1、reg.test(str) 用来验证字符串是否符合正则 符合返回 true ，否则返回false

参考 W3C 文档：《[JavaScript test() 方法](http://www.w3school.com.cn/jsref/jsref_test_regexp.asp)》

``` javascript
var str = 'abc';
var reg = /\w+/;
console.log(reg.test(str)); // true
```

2、reg.exec() 用来捕获符合规则的字符串

参考 W3C 文档：《[JavaScript exec() 方法](http://www.w3school.com.cn/jsref/jsref_exec_regexp.asp)》

``` javascript
var str = 'abc123cba456aaa789';
var reg = /\d+/;
console.log(reg.exec(str)); // ["123", index: 3, input: "abc123cba456aaa789"];

// reg.exec 捕获的数组中：[0: "123", index: 3, input: "abc123cba456aaa789"]
// 0:     "123"                 表示我们捕获到的字符串
// index: 3                     表示捕获开始位置的索引
// input: "abc123cba456aaa789"  表示原有的字符串
```

当我们用exec进行捕获时，如果正则没有加 g 标识符，则 exec 捕获的每次都是同一个，当正则中有 g 标识符时 捕获的结果就不一样了,我们还是来看刚刚的例子：

``` javascript
var str = 'abc123cba456aaa789';
var reg = /\d+/g; // 加标识符g

console.log(reg.lastIndex); // lastIndex : 0 

console.log(reg.exec(str)); // ["123", index: 3, input: "abc123cba456aaa789"]

console.log(reg.lastIndex); // lastIndex : 6

console.log(reg.exec(str)); // ["456", index: 9, input: "abc123cba456aaa789"]

console.log(reg.lastIndex); // lastIndex : 12

console.log(reg.exec(str)); // ["789", index: 15, input: "abc123cba456aaa789"]

console.log(reg.lastIndex); // lastIndex : 18

console.log(reg.exec(str)); // null

console.log(reg.lastIndex); // lastIndex : 0

// 每次调用 exec 方法时，捕获到的字符串都不相同
// lastIndex 这个属性记录的就是下一次捕获从哪个索引开始。
// 当未开始捕获时，这个值为0。          
// 如果当前次捕获结果为null。那么lastIndex的值会被修改为 0，下次从头开始捕获。
// 而且这个 lastIndex 属性还支持人为赋值。
```

exec的捕获还受分组 () 的影响

``` javascript
var str = '2018-12-09';
var reg = /-(\d+)/g
var res = '';
while ((res=reg.exec(str))) {
  console.log(res);
}
// res 的结果分别如下：
// ["-12", "12", index: 4, input: "2018-12-09"]
// ["-09", "09", index: 7, input: "2018-12-09"]

// "-12" 正则捕获到的内容
// "12"  捕获到的字符串中的小分组中的内容
```

3、str.match(reg) 如果匹配成功，就返回匹配成功的数组，如果匹配不成功，就返回 null

参考 W3C 文档：《[JavaScript match() 方法](http://www.w3school.com.cn/jsref/jsref_match.asp)》

``` javascript
// match和exec的用法差不多
var str = 'abc123cba456aaa789';
var reg = /\d+/;
console.log(reg.exec(str));  // ["123", index: 3, input: "abc123cba456aaa789"]
console.log(str.match(reg)); // ["123", index: 3, input: "abc123cba456aaa789"]
```

上边两个方法 console 的结果有什么不同呢？二个字符串是一样的，当我们进行全局匹配时，二者的不同就会显现出来了：

``` javascript
var str = 'abc123cba456aaa789';
var reg = /\d+/g;
console.log(reg.exec(str));  // ["123", index: 3, input: "abc123cba456aaa789"]
console.log(str.match(reg)); // ["123", "456", "789"]
```

当全局匹配时，match 方法会一次性把符合匹配条件的字符串全部捕获到数组中，如果想用 exec 来达到同样的效果需要执行多次 exec 方法，或者 while 循环。

我们可以尝试着用 exec 来简单模拟下 match 方法的实现：

``` javascript
var str = 'abc123cba456aaa789';
var reg = /\d+\w/g;

// 原生 match 方法
console.log(str.match(reg));

String.prototype._match = function (reg) {
  var res = [];
  var match = '';
  while ((match = reg.exec(str))) {
    res.push(match[0]);
  }
  return res;
}

// 自定义的 _match 方法
console.log(str._match(reg));
```

此外，match 和 exec 都可以受到分组 () 的影响，不过 match 只在没有标识符 g 的情况下才显示小分组的内容，如果有全局 g，则 match 会一次性全部捕获放到数组中。

4、str.replace() 在字符串中 用一些字符 替换 另一些字符，或 替换一个 与 正则表达式匹配的 子串。

参考 W3C 文档：《[JavaScript replace() 方法](http://www.w3school.com.cn/jsref/jsref_replace.asp)》

正则去匹配字符串，匹配成功的字符去替换成新的字符串，写法：str.replace(reg, newStr);

``` javascript
var str = 'a111bc222de';
var res = str.replace(/\d/g, 'Q')
console.log(res); // "aQQQbcQQQde"
```

replace的第二个参数也可以是一个函数，str.replace(reg, fn)

``` javascript
var str = '2018-12-09';
str = str.replace(/-\d+/g, function () {
  console.log(arguments);
})
```

以上代码，控制台打印结果：

["-12", 4, "2018-12-09"]

["-09", 7, "2018-12-09"]

从打印结果我们发现每一次输出的值似乎跟 exec 捕获时很相似，既然与 exec 似乎很相似，那么似乎也可以打印出小分组中的内容： 

``` javascript
var str = '2018-12-09';
str = str.replace(/-(\d+)/g, function () {
  console.log(arguments);
})
```

以上代码，控制台打印结果：

["-12", "12", 4, "2018-12-09"]

["-09", "09", 7, "2018-12-09"]

此外，我们需要注意的是，如果我们需要替换replace中正则找到的字符串，函数中需要一个返回值去替换正则捕获的内容。

通过replace方法获取url中的参数的方法：

``` javascript
String.prototype._queryString = function queryString(){
  var obj = {};
  var reg = /([^?&#+]+)=([^?&#+]+)/g;
  this.replace(reg, function ($0, $1, $2) {
    obj[$1] = $2;
  })
  return obj;
}
console.log('https://www.baidu.com?a=1&b=2'._queryString());
```

### 零宽断言

用于查找在某些内容（但并不包括这些内容）之前或之后的东西，如 \b，^, $ 那样用于指定一个位置，这个位置应该满足一定的条件（即断言），因此它们也被称为零宽断言。

#### 在使用正则表达式时，捕获的内容前后必须是特定的内容，而我们又不想捕获这些特定内容的时候，零宽断言就可以派上用场了。

1、零宽度正预测先行断言 (?=exp)：字符出现的位置的右边必须匹配到 exp 这个表达式

``` javascript
var str = "i'm singing and dancing";
var reg = /\b(\w+(?=ing\b))/g
var res = str.match(reg);
console.log(res); // ["sing", "danc"]
```

注意一点，这里说到的是位置，不是字符。

``` javascript
var str = 'abc';
var reg = /a(?=b)c/;
console.log(res.test(str));  // false
```

上面的正则匹配看起来似乎是正确的，实际上结果是false。reg中 a(?=b) 匹配字符串 'abc'， 字符串 a 的右边是 b 这个匹配没问题，接下来 reg 中 a (?=b) 后边的 c 匹配字符串时是从字符串 'abc' 中 a 的后边 b 的前边的这个位置开始匹配的，这个相当于 /ac/ 匹配 'abc'，所以结果是 false 。

2、零宽度负预测先行断言 (?!exp)：字符出现的位置的右边不能是 exp 这个表达式

``` javascript
var str = 'nodejs';
var reg = /node(?!js)/;
console.log(reg.test(str)) // false
```

3、零宽度正回顾后发断言 (?<=exp)：字符出现的位置的前边是 exp 这个表达式

``` javascript
var str = '￥998$888';
var reg = /(?<=\$)\d+/;
console.log(reg.exec(str)) // 888
```

4、零宽度负回顾后发断言 (?<!exp)：字符出现的位置的前边不能是exp这个表达式

``` javascript
var str = '￥998$888';
var reg = /(?<!\$)\d+/;
console.log(reg.exec(str)) // 998
```

本文部分内容参考自：http://www.cnblogs.com/chenmeng0818/p/6370819.html。

