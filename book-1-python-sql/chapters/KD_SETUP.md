# Project Directories and Files

Now it's time to build the directory and file structure for a Kneel Diamonds API.

## Directory and Code Setup

```sh
cd ~/workspace
mkdir kneel-server
cd kneel-server
mkdir .vscode
touch json-server.py .pylintrc Pipfile nss_handler.py
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
```

1. Copy the contents of the following files from the Shipping Ships API project into your new project files.
    - `.pylintrc`
    - `Pipfile`
    - `.vscode/launch.json`
    - `.vscode/settings.json`

Then activate a virtual environment and install packages.

```sh
pipenv shell
pipenv install
```

Once that it complete, open the project directory in Visual Studio Code.
