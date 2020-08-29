# Karen's Level Up Requirements

## Meeting Karen

> Insert dialogue here

## Create API Application

Now that the project is set up and has some initial configuration, it's time to create an application for the Level Up API project. Django projects are containers for one, or more, applications. Right now, we only need one application in this project. Make sure you are in your project directory when you run this command.

```sh
python manage.py startapp levelupapi
```

## Setting Up Package Directories

Run the following commands to remove some boilerplate files that you won't be using, and create directories that will contain the code for your application.

```sh
cd levelupapi
rm models.py views.py
mkdir models
mkdir views
```

## Update Settings

Below, there are four sections of your project's `settings.py` module. Replace your existing sections with the code below.

> #### `levelup/levelup/settings.py`

```py
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
    'levelupapi',
]

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.LimitOffsetPagination',
    'PAGE_SIZE': 10
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
```


## Design Models

> Insert narrative for meeting Karen and her stumbling walkthrough of what she wants.

1. Django Users
1. Gamers with 1 -> 1 to Users
1. Game types
1. Gamer games
1. Gamer events
1. GamerEvents &infin; -> &infin; model
1. import all models to `__init__.py`

## Migration of app models

```sh
python manage.py makemigrations levelupapi
```
