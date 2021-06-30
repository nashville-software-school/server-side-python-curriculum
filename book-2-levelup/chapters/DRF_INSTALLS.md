# DRF Installations and Configuration

## Setup

The initial creation of a Django project is not difficult, but it is very time intensive. It's mostly just mind-numbing, busy work so 🐻 with it. There's no way around it.

## Virtual Environment with `pipenv`

Virtual environments make sure that each project you build is clean and isolated from all of the other projects that may be on your system. This ensures that different projects can use specific versions of 3rd party software without conflicts.

Run the following commands to install `pipenv`, which is an easy to use tool for managing virtual environments for Python projects.

```sh
pip3 install --user pipx
pipx install pipenv
```

## Creating the Project and Virtual Environment

Do not copy all of these at once and paste them into your terminal. Copy and run each one separately.

```sh
cd ~/workspace/python
mkdir levelup
cd levelup
pipenv shell
```

Next, install these third-party packages for use in your project.

```sh
pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
```

Then you can create your very first Django project with the following command. Make sure you are in the `~/workspace/python/levelup` directory. Don't forget the `.` at the end of the command

```sh
django-admin startproject levelup .
```

## Controlling Lint Errors

### Add Pylint file
The pylint package is very good at ensuring that you follow the community standards for variable naming, but there are certain times that you want to use variable names that are short and don't use snake case. You can put those variable names in a `.pylintrc` file in your project.

Without this configuration, your editor will put orange squiggles under those variable names to alert you that you violated community standards. It becomes annoying, so you override the default rules.

```sh
echo '[FORMAT]
good-names=i,j,ex,pk

[MESSAGES CONTROL]
disable=broad-except

[MASTER]
disable=C0114,
' > .pylintrc
```
### Select Python Interpreter
Open VSCode and press `cmd+shift+p` and select "Python: Select Interpretor". Find the option that has `<your folder name>-<random string>`

### Configure Pylint
After selecting the python interpreter, there should be a popup to enable pylint, click yes. There should now be a .vscode folder in your directory. Open the settings.json file and add the following lines:

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django"
],
"python.linting.pylintArgs": [
    "--django-settings-module=<folder name>.settings",
],
```
Notice that `<folder name>` should be the name of the folder that has the `settings.py` file

## Create API Application

Now that the project is set up and has some initial configuration, it's time to create an application for the Level Up API project. Django projects are containers for one, or more, applications. Right now, we only need one application in this project. Make sure you are in your project directory when you run this command.

```sh
python3 manage.py startapp levelupapi
```

If that command throws errors, try this one.

```sh
python3 manage.py startapp levelupapi
```

## Add Content To .gitignore File

Create a `.gitignore` file by running the following command

```sh
touch .gitignore
```

Next generate the content for your `.gitignore` file by running this command

```sh
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
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

## Create Base Django Tables

Django gives user and role management tables for your application out of the box, and there is a built-in migration file that makes the tables in a SQLite database for you. Go ahead and run that migration to set up the initial tables.

```sh
python3 manage.py migrate
```

---

## Optional - Hide Secret Key
### Do this step if you know you will be deploying this app
1. Create a `.env` file on the same level as the `manage.py` file. 
2. In the terminal run: `python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'`, copy the output
3. Open the `.env` file and add `SECRET_KEY=<paste output>` without the angle brackets
4. In the `settings.py` file around line 23 change the `SECRET_KEY` variable to be `SECRET_KEY = os.environ.get('SECRET_KEY')`
5. Stop and restart the pipenv shell
