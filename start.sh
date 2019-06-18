#!/bin/bash
#
echo "start mysql ----------------"
source ./mysql/start_mysql.sh

echo "start django-blog ----------------"
source ./django-blog/start_django_blog.sh
#./init_django.sh

echo "start nginx ----------------"
source ./nginx/start_nginx.sh