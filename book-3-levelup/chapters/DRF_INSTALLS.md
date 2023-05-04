# DRF Installations and Configuration

## Setup

The initial creation of a Django project is not difficult, but it is very time intensive. It's mostly just mind-numbing, busy work so 🐻 with it. There's no way around it.

## Creating the Project and Virtual Environment

Do not copy all of these at once and paste them into your terminal. Copy and run each one separately.

```sh
cd ~/workspace # go to your workspace
```
```sh
mkdir levelup-server # create a new directory
```
```sh
cd levelup-server # cd into that directory
```
```sh
code . # open VSCode
```
```sh
pipenv shell # initialize a new virtual environment
```

Next, install these third-party packages for use in your project.

```sh
pipenv install django autopep8 pylint djangorestframework django-cors-headers pylint-django
```

Then you can create your very first Django project with the following command. Make sure you are in the `~/workspace/levelup-server` directory by running `pwd`. 

**Don't forget the `.` at the end of the command below**. Pro-tip: Use the copy button to grab all of the code.

```sh
django-admin startproject levelup .
```

## Controlling Lint Errors

### Add Pylint file

The pylint package is very good at ensuring that you follow the community standards for variable naming, but there are certain times that you want to use variable names that are short and don't use snake case. You can put those variable names in a `.pylintrc` file in your project.

Without this configuration, your editor will put orange squiggles under those variable names to alert you that you violated community standards. It becomes annoying, so you override the default rules.

```sh
echo '[FORMAT] \n  good-names=i,j,ex,pk\n\n[MESSAGES CONTROL]\n  disable=broad-except,imported-auth-user,missing-class-docstring,no-self-use,abstract-method\n\n[MASTER]\n  disable=C0114,\n' > .pylintrc
```

### Select Python Interpreter

Open VS Code and press <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows) to open the Command Palette, and select "Python: Select Interpreter".

Find the option that has:

`<your folder name>-<random string>`

### Configure Pylint

After selecting the python interpreter, you may see a pop-up asking if you'd like to enable Pylint. If so, click yes.

Otherwise, open the VS Code Command Palette <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows), and select "Python: Select Linter".

Find the option that has:

`pylint`

#### Pylint Settings for Django

There should now be a .vscode folder in your directory. Open the `settings.json` file and add the following lines:

> `levelup-server/.vscode/settings.json`

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django",
    "--django-settings-module=<folder name>.settings",
],
```

#### *Notice that `<folder name>` should be the name of the folder that has the `settings.py` file, in this case it will be `levelup.settings`*

## Create API Application

Now that the project is set up and has some initial configuration, it's time to create an application for the Level Up API project. Django projects are containers for one, or more, applications. Right now, we only need one application in this project.

#### *Make sure you are in your `levelup-server` directory when you run this command.*

```sh
python3 manage.py startapp levelupapi
```

## Add Content To .gitignore File

Create a `.gitignore` file and generate the content for it by running this command

```sh
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
```

## Setting Up Package Directories

Run the following commands to remove some boilerplate files that you won't be using, and create directories that will contain the code for your application.

```sh
rm levelupapi/models.py levelupapi/views.py
mkdir levelupapi/models levelupapi/views
touch levelupapi/models/__init__.py levelupapi/views/__init__.py
```

## Update Settings

Below, there are four sections of your project's `settings.py` module. Replace your existing sections with the code below.

These settings changes will be needed for any REST API application that you make. The only thing that will differ between applications is the name of the application itself.

Below, you can see `levelupapi` in the list of installed apps. Whatever project you create in the future, your application names in that project will go there instead.

> `levelup-server/levelup/settings.py`

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
    'levelupapi',
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

## Optional - Hide Secret Key

### *Do this step if you know you will be deploying this ap*

1. From your `levelup-server` directory, run the following command to create a `.env` file on the same level as your `manage.py` file.

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

### Running the Django Server with VS Code Debugger

Inside the `.vscode` create a file called `launch.json`. Paste the following code in that file.

> `levelup-server/.vscode/launch.json`

```jsonc
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
