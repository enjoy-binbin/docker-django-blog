#### Docker + nginx + mysql + Django 部署博客



#### 使用脚本启动

```
./start.sh
```





#### 1. 先拉取后面需要用到的镜像

拉取Docker官方镜像的时候如果慢可以使用 daocloud.io源，例如 daocloud.io/python:3.6

```
docker pull daocloud.io/nginx:1.14

docker pull daocloud.io/python:3.6

docker pull daocloud.io/mysql:5.6.30
```





