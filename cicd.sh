#!/bin/bash
set -e  # 에러 발생 시 스크립트 중단

# 환경 변수 설정
PROJECT_DIR="/home/ubuntu/djangonV"
DJANGO_MANAGE="$PROJECT_DIR/manage.py"
STATIC_DIR="/var/www/html"

echo "==> Pulling latest changes from Git"
cd $PROJECT_DIR
git pull

echo "==> Activating virtual environment"
source $PROJECT_DIR/venv/bin/activate

echo "==> Installing dependencies"
pip install -r requirements.txt

echo "==> Running migrations"
python $DJANGO_MANAGE migrate

echo "==> Collecting static files"
python $DJANGO_MANAGE collectstatic --noinput

echo "==> Restarting Gunicorn (if applicable)"
pkill -f "gunicorn" || true
nohup gunicorn --bind 0:8000 taskManager.wsgi:application > /dev/null 2>&1 &

echo "==> Restarting Nginx (if applicable)"
sudo systemctl restart nginx

echo "==> Deployment completed successfully!"
