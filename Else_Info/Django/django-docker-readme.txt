

------------------------------------------------------------------------

Variant-1.

------------------------------------------------------------------------

docker-compose.yml
manage.py
Dockerfile

Dockerfile:

FROM python:3

RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean

RUN mkdir -p /site

COPY . /site/

WORKDIR /site/

RUN pip install --upgrade pip
RUN pip install django

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]



$ sudo docker build .

docker-compose.yml

version: '3'
services:
	web:
		container_name: web_app
		build: .
		restart: on_failure
		ports:
			- "8000:8000"
		volumes:
			- ./src:/site/src
	
	ubuntu:
		container_name: ubuntu_container
		image: ubuntu




------------------------------------------------------------------------

Variant-2.

------------------------------------------------------------------------

$ nano project/requirements.txt
Django
django-environ
gunicorn
psycorg2

---------------------------------

$ nano project/Dockerfile

FROM python:3.9-alpine

WORKDIR /project

ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1

COPY . .

RUN apk add --update --no-cache --virtual .tmp-build-deps \
	gcc libc-dev linux-headers postgresql-dev && \
	pip install --no-cache-dir -r requirements.txt

---------------------------------

$ nano settings.py

from pathlib import Path

import environ
env = environ.Env()

STATIC_URL = "/staticfiles"
STATIC_ROOT = os.path.join(BASE_DIR, "static")

ALLOW_HOSTS = ["test.world-itech.ru",]

DATABASES = {
	'default': env.db(),
}

---------------------------------

$ nano ./nginx-conf.d/test.world-itech.ru.conf

upstream app {
	server django:8000;
}

server {
	
	listen 80;
	server_name test.world-itech.ru;
	access_log /var/log/nginx/test.world-itech.ru-access.log;
	error_log /var/log/nginx/test.world-itech.ru-error.log;
	
	location / {
		proxy_pass http://app;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $host;
		proxy_redirect off;
	}
	
	location /staticfiles/ {
		alias /var/www/html/staticfiles/;
	}
	
}

---------------------------------

$ nano docker-compose.yml

version: '3.9'
services:
	django:
		build: ./project
		command: sh -c "gunicorn --bind 0.0.0.0:8000 app.wsgi"
		volumes:
			- ./project:/project
			- static_data:/project/static
		expose:
			- 8000
		environment:
			- DATABASE_URL=postgresql://django:django_QWErty!2)4@db:5432/django
			- DEBUG=1
	
	db:
		image: postgres:13-alpine
		volumes:
			- pg_data:/var/lib/postgresql/data
		expose:
			- 5432
		environment:
			- POSTGRES_USER=django
			- POSTGRES_PASSWORD=django_QWErty!2)4
			- POSTGRES_DB=django
	
	nginx:
		image: nginx:1.19.8-alpine
		depends_on:
			- django
		ports:
			- "80:80"
		volumes:
			- static_data:/var/www/html/static
			- ./nginx-conf.d:/etc/nginx/conf.d

volumes:
	pg_data:
	static_data:

---------------------------------














