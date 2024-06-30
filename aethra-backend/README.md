pip freeze > requirements.txt
docker-compose exec backend python manage.py migrate
docker-compose exec backend python manage.py runserver 0.0.0.0:8001
