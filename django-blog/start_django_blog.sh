#!/bin/bash
# 根据Dockfile创建镜像, 并且启动容器 by binbin

# docker exec 执行mysql容器里的mysql命令 创建数据库
docker exec -d mysql mysql -uroot -p123456 -e "create database blog;"

# 根据当前目录下的Dockerfile创建镜像
docker build -t bin/django-blog .

echo "---------Start django-blog image---------"
# 启动django-blog容器(先mysql、再django-blog、再nginx)
# --link 链接mysql容器, 注意容器的启动顺序 在容器里面可以ping mysql
# -v 挂载共享目录, 把项目代码共享出去
# -p 端口映射, 容器内的8000映射到主机的8001
# -d 后台运行
# bin/django-blog 镜像名
# 执行的命令 gunicorn安装后是在那里的
docker run --name django-blog \
--link mysql \
-v /var/www/Django-blog \
-p 8001:8000 \
-dit bin/django-blog /bin/bash

echo "---------End django-blog image---------"
# 进入容器的方法 django-blog 容器名
# docker container inspect --format "{{.State.Pid}}" django-blog
# docker inspect --format "{{.State.Pid}}" django-blog
# 37834
#
# nsenter参数说明: http://man7.org/linux/man-pages/man1/nsenter.1.html
# nsenter --target 37834 --mount --uts --ipc --net --pid
# doing... 可以先自己在这里启动runserver看看是否通
# 退出容器
# exit