# Installations and Configuration

## Setup

The initial creation of a Django REST Framework project is not difficult, but it is very time intensive. It's mostly just mind-numbing, busy work so 🐻 with it. There's no way around it.

## Creating the Project and Virtual Environment

Do not copy all of these at once and paste them into your terminal. Copy and run each one separately.

```sh
cd ~/workspace
mkdir honey-rae-server
cd honey-rae-server
touch seed_database.sh
touch db.sqlite3
pipenv shell
```

<img src="./images/honey-rae-env-setup.gif" alt="animation of commands for virtual environment" width="800px">

Next, install these third-party packages for use in your project.

```sh
pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
```

Then you can create your very first Django project with the following command. Make sure you are in the `~/workspace/python/honey-rae-server` directory. Don't forget the `.` at the end of the command

```sh
# DON'T FORGET THE DOT
django-admin startproject honeyrae .
```

## Controlling Lint Errors

### Add Pylint file

The pylint package is very good at ensuring that you follow the community standards for variable naming, but there are certain times that you want to use variable names that are short and don't use snake case. You can put those variable names in a `.pylintrc` file in your project.

Without this configuration, your editor will put orange squiggles under those variable names to alert you that you violated community standards. It becomes annoying, so you override the default rules.

```sh
echo '[FORMAT]
good-names=i,j,ex,pk

[MESSAGES CONTROL]
disable=broad-except,imported-auth-user,missing-class-docstring,no-self-use,abstract-method

[MASTER]
disable=C0114
' > .pylintrc
```

### Select Python Interpreter

Open VS Code and press <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows) to open the Command Palette, and select "Python: Select Interpreter".

Find the option that has:

`honeyrae-<random string>`

#### Pylint Settings for Django

There should now be a .vscode folder in your directory. Open the `settings.json` file and add the following key to the existing object in there:

> `honey-rae-server/.vscode/settings.json`

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django",
    "--django-settings-module=honeyrae.settings",
],
```

If there is no `settings.json` file, create one and add the following to it.

```json
{
    "python.linting.pylintArgs": [
        "--load-plugins=pylint_django",
        "--django-settings-module=honeyrae.settings",
    ],
}
```

## Create API Application

Now that the project is set up and has some initial configuration, it's time to create an application for the Level Up API project. Django projects are containers for one, or more, applications. Right now, we only need one application in this project.

#### *Make sure you are in your `honey-rae-server` directory when you run this command.*

```sh
python3 manage.py startapp repairsapi
```

## Add Content To .gitignore File

Create a `.gitignore` file and generate the content for it by running this command

```sh
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
echo '*.sqlite3' >> .gitignore
```

## Setting Up Package Directories

Run the following commands to remove some boilerplate files that you won't be using, and create directories that will contain the code for your application.

```sh
rm repairsapi/models.py repairsapi/views.py
mkdir repairsapi/models repairsapi/views
touch repairsapi/models/__init__.py repairsapi/views/__init__.py
```

## Update Settings

Below, there are four sections of your project's `settings.py` module. Replace your existing sections with the code below.

These settings changes will be needed for any REST API application that you make. The only thing that will differ between applications is the name of the application itself.

Below, you can see `repairsapi` in the list of installed apps. Whatever project you create in the future, your application names in that project will go there instead.

> `honey-rae-server/honeyrae/settings.py`

```py

# UPDATE THIS
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
    'repairsapi',
]

# THIS IS NEW
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
}

# THIS IS NEW
CORS_ORIGIN_WHITELIST = (
    'http://localhost:3000',
    'http://127.0.0.1:3000'
)

# UPDATE THIS
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


### Running the Django Server with VS Code Debugger

Inside the `.vscode` create a file called `launch.json`. Paste the following code in that file.

> `honey-rae-server/.vscode/launch.json`

```json
{
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
```

## Optional - Hide Secret Key

<details>
    <summary>Do this only if you will be deploying this project to the public Cloud</summary>


1. From your `honey-rae-server` directory, run the following command to create a `.env` file on the same level as your `manage.py` file.

    ```zsh
    touch .env
    ```

1. In the terminal run:

    ```zsh
    python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
    ```

1. Copy the output.

1. Open the `.env` file in VS Code, and add `MY_SECRET_KEY=<paste output>` (without the angle brackets, and without any quotes)

1. Open the `settings.py` file in your `levelup` directory.

1. Locate the the `SECRET_KEY` variable (around line 23), and change it to be `SECRET_KEY = os.environ.get('MY_SECRET_KEY')`

1. Import `os` at the top of your `settings.py` file.

1. Stop your virtual environment <kbd>Ctrl</kbd><kbd>D</kbd>, and then restart it `pipenv shell`.
</details>
