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