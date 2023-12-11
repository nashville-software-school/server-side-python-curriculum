#!/bin/bash

echo "Enter a single word to prefix your project name and API app name:"
read -p "> " PROJECT_NAME

curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
echo 'db.sqlite3' >> .gitignore
pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
django-admin startproject ${PROJECT_NAME}project .
python3 manage.py startapp ${PROJECT_NAME}api
mkdir ./.vscode
mkdir ./${PROJECT_NAME}api/fixtures
mkdir ./${PROJECT_NAME}api/models
touch ./${PROJECT_NAME}api/models/__init__.py
mkdir ./${PROJECT_NAME}api/views
touch ./${PROJECT_NAME}api/views/__init__.py
rm ./${PROJECT_NAME}api/views.py
rm ./${PROJECT_NAME}api/models.py

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
        "--django-settings-module='${PROJECT_NAME}'project.settings",
    ]
}
' > ./.vscode/settings.json

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
    '${PROJECT_NAME}api',
]

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
}

CORS_ORIGIN_WHITELIST = (
    'http://localhost:3000',
    'http://127.0.0.1:3000',
    'http://localhost:5173',
    'http://127.0.0.1:5173',
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

ROOT_URLCONF = '${PROJECT_NAME}project.urls'

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

WSGI_APPLICATION = '${PROJECT_NAME}project.wsgi.application'


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
" > ./${PROJECT_NAME}project/settings.py

echo "from django.contrib import admin
from django.urls import include, path
from rest_framework import routers

router = routers.DefaultRouter(trailing_slash=False)

urlpatterns = [
    path('', include(router.urls)),
]
" > ./${PROJECT_NAME}project/urls.py

echo "#!/bin/bash

rm db.sqlite3
rm -rf ./${PROJECT_NAME}api/migrations
python3 manage.py migrate
python3 manage.py makemigrations ${PROJECT_NAME}api
python3 manage.py migrate ${PROJECT_NAME}api
python3 manage.py loaddata users
python3 manage.py loaddata tokens
" > ./seed_database.sh

chmod +x ./seed_database.sh


echo '[FORMAT]
  good-names=i,j,ex,pk

[MESSAGES CONTROL]
  disable=broad-except,imported-auth-user,missing-class-docstring,no-self-use,abstract-method

[MASTER]
  disable=C0114,
' > .pylintrc

pipenv run bash -c "python3 manage.py migrate"
git init
git add --all
git commit -m "Initial commit"
