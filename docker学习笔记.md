### https://opsx.alibaba.com/mirror

#### 虚拟机Centos根据光盘rpm安装包

```
mkdir /media
mount /dev/cdrom /media
cd /media/Packages

find wget*

rpm -ivh wget-1.14-18.el7.x86_64.rpm
```



#### 设置阿里源，虚拟机是设置的nat网络

```
cd /etc/yum.repos.d

yum install -y wget
wget -4 http://mirrors.aliyun.com/repo/Centos-7.repo

# 备份原有CentOS-Base.repo
# 将阿里源命名为CentOS-Base.repo

mv CentOS-Base.repo CentOS-Base.repo.bak
cp Centos-7.repo CentOS-Base.repo

yum clean all
yum makecache

yum -y install vim
```



#### 安装docker

```
# https://www.runoob.com/docker/centos-docker-install.html
# 安装一些必要的系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# 添加软件源信息：
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 更新 yum 缓存：
yum makecache fast

# 安装 Docker-ce：
sudo yum -y install docker-ce

# 启动 Docker 后台服务
systemctl start docker

# docker hello world
docker run hello-world
```



## 镜像加速

鉴于国内网络问题，后续拉取 Docker 镜像十分缓慢，我们可以需要配置加速器来解决，我使用的是网易的镜像地址：**http://hub-mirror.c.163.com**。

新版的 Docker 使用 /etc/docker/daemon.json（Linux） 或者 %programdata%\docker\config\daemon.json（Windows） 来配置 Daemon。

请在该配置文件中加入（没有该文件的话，请先建一个）：

```
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```





## 运行一个web应用

前面我们运行的容器并没有一些什么特别的用处。

接下来让我们尝试使用 docker 构建一个 web 应用程序。

我们将在docker容器中运行一个 Python Flask 应用来运行一个web应用。

```
docker pull training/webapp  # 载入镜像

# -d 容器在后台运行, -P 容器网络端口 随机映射虚拟机端口
docker run -d -P training/webapp python app.py

[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
f7b534b9be60        training/webapp     "python app.py"     10 seconds ago      Up 9 seconds        0.0.0.0:32768->5000/tcp   vigorous_villani

# 浏览器上访问 虚拟机ip:32768

# 关闭和启动容器 container_id/name
docker stop f7b534b9be60
docker start f7b534b9be60

# 移除已stop的容器
docker rm f7b534b9be60

# -p 手动指定映射端口  --name 指定容器名称
docker run -d -p 80:5000 --name test training/webapp python app.py

# 查看指定容器（id/名称）的端口信息
[root@localhost ~]# docker port test
5000/tcp -> 0.0.0.0:80

##### 重命名容器
docker rename test test1
```

##### 查看容器内部的标准输出

```
# -f 参数，让 docker logs 像使用 tail -f 一样来持续输出容器内部的标准输出。
[root@localhost ~]# docker logs test
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
192.168.73.1 - - [14/Jun/2019 09:46:46] "GET / HTTP/1.1" 200 -
192.168.73.1 - - [14/Jun/2019 09:46:46] "GET /favicon.ico HTTP/1.1" 404 -
```



##### 检查查看容器底层信息

使用 **docker inspect container** 来查看容器底层信息，会返回一个json格式的输出记录着容器的配置和状态。

```
[
    {
        "Id": "85e8419b1225d9c03f88f7887aac6ca78d479ab2050d606961010faccc24e9ee",
        "Created": "2019-06-14T09:54:11.2829363Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 11109,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2019-06-14T09:54:11.745808335Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
   ..................
]
```

<https://www.runoob.com/docker/docker-image-usage.html>



### 镜像的使用

```
# 列出本机上的镜像 仓库源/标签/镜像ID/创建时间/大小，标签一般用来指定版本 python:3.6，默认为latest
[root@localhost ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              fce289e99eb9        5 months ago        1.84kB
training/webapp     latest              6fae60ef3446        4 years ago         349MB

# 删除镜像
docker rmi image_id
```

