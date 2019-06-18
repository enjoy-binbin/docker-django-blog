#!/bin/bash
#
echo "start mysql ----------------"
cd mysql
source ./start_mysql.sh

echo "start django-blog ----------------"
cd ../django-blog
source ./start_django_blog.sh
#./init_django.sh

echo "start nginx ----------------"
cd ../nginx
source ./start_nginx.sh