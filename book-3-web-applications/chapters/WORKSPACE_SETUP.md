# Starting a Django Project

## Create Root Project Directory

When you use the `django-admin` command to start a project, it will automatically create a sub-directory with the name you specify. Therefore, be in the directory where you want the new sub-directory to be created.

```sh
cd ~/workspace/python/
```

## Project Creation

Create the main container project, and create your database with all of the tables needed for Django to work.

```sh
django-admin startproject myawesomeproject
cd myawesomeproject
```

## Create Virtual Environment

### OSX

You can name your environment directory whatever you like. Just make sure it is relevant to your project's name.

```sh
python -m venv myawesomeprojectenv
source ./myawesomeprojectenv/bin/activate
pip install django
pip freeze > requirements.txt
```

### Windows

Determine where you want to create your environment directory. Use that path below. **Do not use** `c:\path\to\environment` because that path doesn't exist. Preferably make it inside your project directory. For example, `c:\Users\[me]\workspace\python\[project directory]`.

Windows users cannot use Git Bash, you must do this with Windows Command Line.

```sh
cd workspace\python\myawesomeproject
python -m venv myawesomeprojectenv
cd myawesomeprojectenv
cd Scripts
activate.bat
cd ..
cd ..
pip install django pylint autopep8
pip freeze > requirements.txt
```

## Application Creation

```sh
python manage.py startapp [name of application]
```

## Run Default Django Migration

Running this command from your project directory will create the database and the Django user management tables.

```sh
python manage.py migrate
```

## Project Settings

### Generate Settings

While in Visual Studio Code, press `Cmd+,` or `Ctrl+,` to access the workspace settings. This will generate a `.vscode` directory inside your project directory.

### Windows

Open `.vscode/settings.json` and add the following code.

```sh
{
    "python.pythonPath": "C:\python37"
}
```

### OSX

Open `.vscode/settings.json` and add the following code. Replace `yourusername` with your computer login.

```json
{
    "python.pythonPath": "/Users/{you}/path/to/project/myprojectenv/bin/python"
}
```

## Selecting Interpreter

Use `Cmd+Shift+p` on OSX and `Ctrl+Shift+p` on Windows to open the command pallette. Type in `select interpreter` and choose that command. In the list of options it provides, choose the one that points to your environment directory. It's usually the last option in the list.

![select python interpreter](./images/select-interpreter.gif)

## Create Django Debug Profile

To debug you Django projects, set up a Django profile in the Debug panel.

1. Open the Debug panel
1. If the gear icon at the top of the panel has a red dot on it, then you have no profiles set up yet, so click on the gear.
1. Select Python from the first set of options
1. Select Django from the second set of options
1. Then type in the path to the `manage.py` file relative from where you started Visual Studio Code.

![selecting the python and django debug profile](./images/django-debug-setup.gif)