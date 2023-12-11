#!/bin/bash

pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
django-admin startproject deshawnproject .
python3 manage.py startapp deshawnapi
./manage.py migrate
mkdir ./.vscode
mkdir ./deshawnapi/fixtures
mkdir ./deshawnapi/models
touch ./deshawnapi/models/__init__.py
mkdir ./deshawnapi/serializers
touch ./deshawnapi/serializers/__init__.py
mkdir ./deshawnapi/views
touch ./deshawnapi/views/__init__.py
rm ./deshawnapi/views.py
rm ./deshawnapi/models.py

echo '{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Django",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/manage.py",
            "args": ["runserver"],
            "django": true,
            "autoReload":{
                "enable": true
            }
        }
    ]
}
' > ./.vscode/launch.json

echo '{
    "pylint.args": [
        "--load-plugins=pylint_django",
        "--django-settings-module=deshawnproject.settings",
    ]
}
' > ./.vscode/settings.json

echo '[
    {
        "model": "deshawnapi.dog",
        "pk": 1,
        "fields": {
            "walker": 2,
            "name": "Rocket"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 2,
        "fields": {
            "walker": 1,
            "name": "Ebony"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 3,
        "fields": {
            "walker": 3,
            "name": "Scotty"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 4,
        "fields": {
            "walker": 4,
            "name": "Mac"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 5,
        "fields": {
            "walker": 1,
            "name": "Oreo"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 6,
        "fields": {
            "walker": 4,
            "name": "Churro"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 7,
        "fields": {
            "walker": 2,
            "name": "Angus"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 8,
        "fields": {
            "walker": 3,
            "name": "Butch"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 9,
        "fields": {
            "walker": 1,
            "name": "Dame"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 10,
        "fields": {
            "walker": 1,
            "name": "Sparkle"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 11,
        "fields": {
            "walker": 2,
            "name": "Bolt"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 12,
        "fields": {
            "walker": 3,
            "name": "Lassie"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 13,
        "fields": {
            "walker": 4,
            "name": "Bonnie"
        }
    },
    {
        "model": "deshawnapi.dog",
        "pk": 14,
        "fields": {
            "walker": 2,
            "name": "Element"
        }
    }
]
' > ./deshawnapi/fixtures/dogs.json

echo '[
    {
        "model": "deshawnapi.city",
        "pk": 1,
        "fields": {
            "name": "Chicago"
        }
    },
    {
        "model": "deshawnapi.city",
        "pk": 2,
        "fields": {
            "name": "White Plains"
        }
    },
    {
        "model": "deshawnapi.city",
        "pk": 3,
        "fields": {
            "name": "San Diego"
        }
    },
    {
        "model": "deshawnapi.city",
        "pk": 4,
        "fields": {
            "name": "Boise"
        }
    }
]
' > ./deshawnapi/fixtures/cities.json

echo '[
    {
        "model": "deshawnapi.walker",
        "pk": 1,
        "fields": {
            "city": 4,
            "name": "Alphonse Meron",
            "email": "Mariana14@example.net"
        }
    },
    {
        "model": "deshawnapi.walker",
        "pk": 2,
        "fields": {
            "city": 2,
            "name": "Damara Pentecust",
            "email": "Genesis90@example.org"
        }
    },
    {
        "model": "deshawnapi.walker",
        "pk": 3,
        "fields": {
            "city": 3,
            "name": "Anna Bowton",
            "email": "Braden_Hermann@example.com"
        }
    },
    {
        "model": "deshawnapi.walker",
        "pk": 4,
        "fields": {
            "city": 1,
            "name": "Hunfredo Drynan",
            "email": "Ollie38@example.net"
        }
    }
]
' > ./deshawnapi/fixtures/walkers.json

echo "
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-x9yg09-pv69(#mz@!n(1&c_rxvks#3*v&#vx!%t39p(n(f0gbb'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'rest_framework.authtoken',
    'corsheaders',
    'deshawnapi',
]

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.AllowAny',
    ],
}

CORS_ORIGIN_WHITELIST = (
    'http://localhost:3000',
    'http://127.0.0.1:3000'
)


MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'deshawnproject.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'deshawnproject.wsgi.application'


# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.0/howto/static-files/

STATIC_URL = 'static/'

# Default primary key field type
# https://docs.djangoproject.com/en/4.0/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
" > ./deshawnproject/settings.py

echo "from django.contrib import admin
from django.urls import include, path
from rest_framework import routers
from deshawnapi.views import WalkerView, CityView, DogView

router = routers.DefaultRouter(trailing_slash=False)
router.register(r'walkers', WalkerView, 'walk')
router.register(r'cities', CityView, 'city')
router.register(r'dogs', DogView, 'dog')

urlpatterns = [
    path('', include(router.urls)),
]
" > ./deshawnproject/urls.py

echo "
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from deshawnapi.models import City


class CityView(ViewSet):

    def retrieve(self, request, pk=None):
        # Step 1: Get a single city based on the primary key in the request URL
        city = City.objects.get(pk=pk)

        # Step 2: Serialize the city record as JSON
        serialized = CitySerializer(city, many=False)

        # Step 3: Send JSON response to client with 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)

    def list(self, request):
        # Step 1: Get all city data from the database
        cities = City.objects.all()

        # Step 2: Convert the data to JSON format
        serialized = CitySerializer(cities, many=True)

        # Step 3: Respond to the client with the JSON data and 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)


class CitySerializer(serializers.ModelSerializer):

    class Meta:
        model = City
        fields = ('id', 'name',)
" > ./deshawnapi/views/city_view.py

echo "from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from deshawnapi.models import Dog


class DogView(ViewSet):

    def retrieve(self, request, pk=None):
        # Step 1: Get a single dog based on the primary key in the request URL
        dog = Dog.objects.get(pk=pk)

        # Step 2: Serialize the dog record as JSON
        serialized = DogSerializer(dog, many=False)

        # Step 3: Send JSON response to client with 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)

    def list(self, request):
        # Step 1: Get all dog data from the database
        cities = Dog.objects.all()

        # Step 2: Convert the data to JSON format
        serialized = DogSerializer(cities, many=True)

        # Step 3: Respond to the client with the JSON data and 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)


class DogSerializer(serializers.ModelSerializer):

    class Meta:
        model = Dog
        fields = ('id', 'name', 'walker', )
" > ./deshawnapi/views/dog_view.py

echo "
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from deshawnapi.models import Walker


class WalkerView(ViewSet):

    def retrieve(self, request, pk=None):
        # Step 1: Get a single walker based on the primary key in the request URL
        walker = Walker.objects.get(pk=pk)

        # Step 2: Serialize the walker record as JSON
        serialized = WalkerSerializer(walker, many=False)

        # Step 3: Send JSON response to client with 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)

    def list(self, request):
        # Step 1: Get all walker data from the database
        cities = Walker.objects.all()

        # Step 2: Convert the data to JSON format
        serialized = WalkerSerializer(cities, many=True)

        # Step 3: Respond to the client with the JSON data and 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)


class WalkerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Walker
        fields = ('id', 'name', 'email', 'city', )
" > ./deshawnapi/views/walker_view.py

echo "from django.db import models


class Dog(models.Model):
    name = models.CharField(max_length=155)
    walker = models.ForeignKey('Walker', on_delete=models.CASCADE, related_name='dogs')
" > ./deshawnapi/models/dog.py

echo "from django.db import models


class Walker(models.Model):
    name = models.CharField(max_length=155)
    email = models.CharField(max_length=155)
    city = models.ForeignKey('City', on_delete=models.CASCADE, related_name='walkers')
" > ./deshawnapi/models/walker.py

echo "from django.db import models


class City(models.Model):
    name = models.CharField(max_length=155)
" > ./deshawnapi/models/city.py

echo "from .city import City
from .walker import Walker
from .dog import Dog
" > ./deshawnapi/models/__init__.py

echo "from .city_view import CityView
from .dog_view import DogView
from .walker_view import WalkerView
" > ./deshawnapi/views/__init__.py

echo '[FORMAT]
  good-names=i,j,ex,pk

[MESSAGES CONTROL]
  disable=broad-except,imported-auth-user,missing-class-docstring,no-self-use,abstract-method

[MASTER]
  disable=C0114,
' > .pylintrc

python3 manage.py makemigrations deshawnapi
python3 manage.py migrate
python3 manage.py loaddata cities
python3 manage.py loaddata walkers
python3 manage.py loaddata dogs