redis是开源的，C语言开发的，安装步骤：先下载源码，再编译（依赖gcc环境），再安装设置。

### gcc 环境

检查是否安装gcc环境：

rpm -qa|grep gcc*

如果没有安装gcc环境，则先安装：

yum install gcc-c++

### 安装 redis

创建目录，下载源码（通过华为镜像），解压源码：

mkdir /usr/lib/redis

cd /usr/lib/redis/

wget https://mirrors.huaweicloud.com/redis/redis-5.0.5.tar.gz

tar -zxvf redis-5.0.5.tar.gz

进入文件夹编译：

cd ./redis-5.0.5/

make

编译成功之后，开始安装，并检查是否安装了服务：

make PREFIX=/usr/local/redis instal

ls /usr/local/redis/bin

把解压目录下配置文件复制到安装路径下：

cp /usr/lib/redis/redis-5.0.5/redis.conf  /usr/local/redis/

找到 redis 配置文件，修改如下：

vim /usr/local/redis/redis.conf

更改如下：

protected-mode no

daemonize yes

requirepass 你的密码

### 给 redis-server 和 redis-cli 添加短链，方便操作：

ln -s /usr/local/redis/bin/redis-server /usr/bin/redis-server

ln -s /usr/local/redis/bin/redis-cli /usr/bin/redis-cli

### 按照以上安装路径，默认相关命令如下：

查看redis是否开始：ps -ef|grep redis

redis 配置文件 /usr/local/redis/redis.conf

redis 默认端口 6379

redis 指定配置文件：/usr/local/redis/bin/redis-server /usr/local/redis/redis.conf

redis 启动：redis-cli -h IP -p 6379

### 备注

如果出现 redis connect error 的情况，可以先退出，然后重新进入，执行：

redis-server /usr/local/redis/redis.conf

然后再次启动：redis-cli
