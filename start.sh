#!/bin/bash
#
echo "start mysql ----------------"
cd mysql
source ./start_mysql.sh
sleep 3

echo "start django-blog ----------------"
cd ../django-blog
source ./start_django_blog.sh
sleep 3

echo "start nginx ----------------"
cd ../nginx
source ./start_nginx.sh