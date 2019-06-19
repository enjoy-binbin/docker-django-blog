#!/bin/bash
#
# 删除所有None构建失败的镜像
# docker images | grep none | awk '{print $3}' | xargs docker rmi
# 删除本机所有容器
# docker ps -a | awk '{print $1}' | xargs docker rm -f

echo "start mysql ----------------"
cd mysql
source ./start_mysql.sh
sleep 2
# docker exec 执行mysql容器里的mysql命令 创建数据库
docker exec -it mysql mysql -uroot -p123456 -e "create database blog default character set utf8 collate utf8_general_ci;"
sleep 1

echo "start django-blog ----------------"
cd ../django-blog
source ./start_django_blog.sh
sleep 2

echo "start nginx ----------------"
cd ../nginx
source ./start_nginx.sh

cd ..