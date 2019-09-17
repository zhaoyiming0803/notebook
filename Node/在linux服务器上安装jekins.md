### 获得一台linux服务器

可以在阿里云、腾讯云购买一台 1 G 1 核 最基础的服务器，足够自己使用。镜像选择CentOS7.3 64位。

### 安装jdk

Jenkins的运行需要依赖jdk，所以在安装Jenkins之前我们得先把jdk装上。具体步骤参考[《在linux服务器上安装jdk》](https://github.com/zymfe/notebook/blob/master/Node/%E5%9C%A8linux%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E5%AE%89%E8%A3%85jdk.md)

### yum 安装 Jenkins

1、yum的repos中默认是没有Jenkins的，需要先将Jenkins存储库添加到yum repos。

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

2、yum 安装 Jenkins：

yum install jenkins

随后就可以看到系统开始自动下载安装。出现提示是否下载的时候输入 y 并按回车。耐心等待安装完成。

### 修改 jenkins 配置

Jenkins安装了，不过启动之前最好稍微修改一下配置。默认情况是Jenkins是使用Jenkins用户启动的，但这个用户目前系统并没有赋予权限，这里我们将启动用户修改为root；另外Jenkins默认端口是8080，这个跟tomcat的默认端口冲突，我们也修改一下默认端口。

输入命令进入Jenkins配置文件：vi /etc/sysconfig/jenkins

修改 JENKINS_USER 和 JENKINS_PORT 两个配置项为：

JENKINS_USER="root"

JENKINS_PORT="8090"

修改完配置后，保存退出。好了，现在配置文件也修改好了，可以启动Jenkins了。

输入启动命令以启动Jenkins服务：service jenkins start

出现OK表示Jenkins启动成功。在浏览器输入ip:8090进入Jenkins登录页面。

进入登录页面后，Jenkins提示我们需要输入超级管理员密码进行解锁。根据提示，我们可以在/var/lib/jenkins/secrets/initialAdminPassword文件里找到密码。

注入命令找到密码：tail /var/lib/jenkins/secrets/initialAdminPassword

找到密码后，复制密码，粘贴到Jenkins解锁页面，点击Continue继续初始化配置。短暂的等待后，进入插件安装页面。

这里我们点击的 Install suggested plugins，安装默认插件，当然你也可以点击另一个按钮安装指定的插件。

点击后，页面进入了插件下载安装页面。耐心等待全部安装完成。安装完成后，页面自动进入了管理员账户注册页面。

输入信息注册。输入完信息点击Save and Finish。

点击Start using Jenkins，进入Jenkins主页面。

至此，Jenkins安装并初始化完成了。