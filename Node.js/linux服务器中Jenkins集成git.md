### 获得一台linux服务器

可以在阿里云、腾讯云购买一台 1 G 1 核 最基础的服务器，足够自己使用。镜像选择CentOS7.3 64位。

### 准备工作

在开始部署持续构建之前，需要先安装好必备的软件，包含 git、Jenkins。

参考：

[linux服务器上安装git](https://github.com/zymfe/notebook/blob/master/Node/linux%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E5%AE%89%E8%A3%85git.md)

[在linux服务器上安装jekins](https://github.com/zymfe/notebook/blob/master/Node/在linux服务器上安装jekins.md)

### 在Jenkins配置GIT路径

1、登录Jenkins进入欢迎页面，点击 系统管理。

2、进入管理页面，点击 Global Tool Configuration 进入全局工具配置页面。

3、在全局工具配置页面，我们可以配置JDK、GIT、Gradle。这里我们先配置GIT。

4、Name处写上别名，叫什么都行，这里习惯性写git；Path to Git executable这个地方要注意，不是填git文件夹所在路径，需要填写git可执行文件的路径。如果是 yum 安装 git，此处应该填写/usr/libexec/git-core。

点击Save，GIT配置完成。

### 配置Jenkins使用GIT下载代码

刚才在Jenkins中配置了git，现在开始使用git来下载代码。首先，需要在linux上生成一套SSH Key，并将SSH Key和github相关联。

输入命令 ssh-keygen -t rsa -C "zhaoyiming0803@gmail.com" 来生成ssh公私钥。注意把邮箱替换成自己的邮箱。生成的时候会有输入框提示 第一次是让你输入文件的地址，第二次和第三次是输出密码。这里全部敲回车，使用默认地址，不设置密码。

现在SSH公私钥生成好了，输入命令 tail /root/.ssh/id_rsa.pub 来获取公钥。

复制公钥，到github上打开管理页面关联上。

现在Jenkins所在机器的SSH Key和github关联上了。
