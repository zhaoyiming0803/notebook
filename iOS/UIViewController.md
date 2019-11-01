## UIViewController

### 视图控制器，管理视图 View 层级结构

1、自身包含 View，可以理解为一个容器

2、管理 View 视图的生命周期

3、响应用户操作

4、和 APP 整体交互，视图的切换

5、作为一个 container 管理多个 Controller 和动画

### viewController 的生命周期（选择合适的函数处理不同的业务）

1、init

2、viewDidLoad

3、viewWillAppear

4、viewDidAppear

5、viewWillDisappear

6、viewDidDisappear

7、Dealloc

### 职责划分

1、UIView 负责页面内的内容呈现

2、使用基础的 UIViewController 管理多个 UIView

3、UIViewController 在管理 UIView 的同时，负责不同页面的切换

4、UITabBarController 功能就是管理多个 ViewController 切换，通过点击底部对应按钮，选中对应需要展示的 ViewController。国内 APP 一般展示 4-5 个可选项。
