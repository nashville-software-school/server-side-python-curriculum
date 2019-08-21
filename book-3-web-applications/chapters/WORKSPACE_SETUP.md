# Starting a Django Project

## Create Root Project Directory

```sh
cd ~/workspace/python/[directory name]
```

## Create Virtual Environment

### OSX

```sh
python -m venv myprojectenv
source ./myprojectenv/bin/activate
pip install django
pip freeze > requirements.txt
```

### Windows

Determine where you want to create your environment directory. Use that path below. **Do not use** `c:\path\to\environment` because that path doesn't exist. Preferably make it inside your project directory. For example, `c:\Users\[me]\workspace\python\[project directory]`.

```sh
c:\Python37\python -m venv ~/workspace/python/[directory name]/myprojectenv
~/workspace/python/[directory name]/myprojectenv/Scripts/activate.bat
pip install django
pip freeze > requirements.txt
```

## Project Creation

Create the main container project, and create your database with all of the tables needed for Django to work.

```sh
django-admin startproject [name of project]
cd [nameofproject]
python manage.py migrate
```

## Application Creation

```sh
python manage.py startapp [name of application]
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

Use `Cmd+Shift+p` on OSX and `Ctrl+Shift+p` on Windows to open the command pallette. Type in `select interpreter` and choose that command. In the list of options it provides, choose the one that points to your local `env` directory.

![select python interpreter](./images/select-interpreter.gif)

## Create Django Debug Profile

To debug you Django projects, set up a Django profile in the Debug panel.

1. Open the Debug panel
1. If the gear icon at the top of the panel has a red dot on it, then you have no profiles set up yet, so click on the gear.
1. Select Python from the first set of options
1. Select Django from the second set of options
1. Then type in the path to the `manage.py` file relative from where you started Visual Studio Code.

![selecting the python and django debug profile](./images/django-debug-setup.gif)