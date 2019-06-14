# Starting a Django Project

## Create Root Project Directory

```sh
cd ~/workspace/python/[directory name]
```

## Create Virtual Environment

### OSX

```sh
python -m venv env
source ./env/bin/activate
pip install django
pip freeze > requirements.txt
```

### Windows

Determine where you want to create your environment directory. Use that path below. **Do not use** `c:\path\to\environment` because that path doesn't exist. Preferably make it inside your project directory. For example, `c:\Users\[me]\workspace\python\[project directory]`.

```sh
c:\Python37\python -m venv ~/workspace/python/[directory name]/env
~/workspace/python/[directory name]/env/Scripts/activate.bat
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

## Environment Settings

Change your directory back to the main project directory, and use the `pwd` command to get the absolute path to your current working directory. Copy the output. Then create a `.env` file in your workspace directory. Then you can launch Visual Studio Code.

```sh
cd ..
touch .env
code .
```

Open the `.env` file in Visual Studio Code and put in the following code.

```sh
PYTHONPATH={paste your path here}
```

## Project Settings

### Generate Settings

While in Visual Studio Code, press `Cmd+,` or `Ctrl+,` to access the workspace settings. This will generate a `.vscode` directory inside your project directory.

### Windows

Open `.vscode/settings.json` and add the following code.

```json
{
    "python.pythonPath": "C:\python37",
    "python.envFile": "${workspaceFolder}/.env"
}
```

### OSX

Open `.vscode/settings.json` and add the following code. Replace `yourusername` with your computer login.

```json
{
    "python.pythonPath": "env/bin/python",
    "python.envFile": "${workspaceFolder}/.env"
}
```

## Selecting Interpreter

Use `Cmd+Shift+p` on OSX and `Ctrl+Shift+p` on Windows to open the command pallette. Type in `select interpreter` and choose that command. In the list of options it provides, choose the one that points to your local `env` directory.

![select python interpreter](./images/select-interpreter.gif)
