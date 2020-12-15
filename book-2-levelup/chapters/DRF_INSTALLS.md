# DRF Installations and Configuration

## Setup

Django is the web application framework that you will be using for the remainder of the course, so you need to install it globally first.

Make sure you are not in an activated virtual environment.

```sh
pip install django
````

The initial creation of a Django project is not difficult, but it is very time intensive. It's mostly just mind-numbing, busy work so 🐻 with it. There's no way around it.

## Creating the Project

```sh
cd ~/workspace/python
django-admin startproject levelup
cd levelup
pipenv shell
```

## Installed Required Packages

Now you use pip to install all of the packages needed for this project.

```sh
pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
```

## Controlling Lint Errors

The pylint package is very good at ensuring that you follow the community standards for variable naming, but there are certain times that you want to use variable names that are short and don't use snake case. You can put those variable names in a `.pylintrc` file in your project.

Without this configuration, your editor will put orange squiggles under those variable names to alert you that you violated community standards. It becomes annoying, so you override the default rules.

```sh
echo '[FORMAT]
good-names=i,j,ex,pk

[MESSAGES CONTROL]
disable=broad-except
' > .pylintrc
```

Open Visual Studio Code in the levelup directory, and then `cmd+shift+p` and open "Preferences: Open Settings (JSON)". Add the following configuration item to the object.

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django"
],
```

## Create Base Django Tables

Django gives user and role management tables for your application out of the box, and there is a built-in migration file that makes the tables in a SQLite database for you. Go ahead and run that migration to set up the initial tables.

```sh
python manage.py migrate
```

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

These settings changes will be needed for any REST API application that you make. The only thing that will differ between applications is the name of the application itself.

Below, you can see `levelupapi` in the list of installed apps. Whatever project you create in the future, your application names in that project will go there instead.

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

