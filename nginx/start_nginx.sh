#!/bin/bash 
#
# build -t 根据dockerfile创建镜像 带标签
# 启动nginx容器(先mysql、再django-blog、再nginx)
# --link link到django-blog容器 django-blog:web 可以起别名
# -v 挂载数据卷里的项目
# -p 80:8000 这个8000是binblog.conf里nginx监听的端口, 映射到主机的80
docker build -t bin/nginx .
#
echo "---------Start nginx image---------"
#
docker run --name nginx \
--link django-blog \
--volumes-from django-blog \
-p 8000:8000 \
-p 80:80 \
-dit bin/nginx /bin/bash
#
echo "---------End nginx image---------"