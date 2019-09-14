# Installations and Configuration for a DRF Project

## Creating the Project

```sh
cd ~/workspace/python
django-admin startproject kennywood
```

## Virtual Environment

A virtual environment allows you to install packages in the scope of this project without polluting global, system package installations.

```sh
cd kennywood
python -m venv KennywoodEnv
source ./KennywoodEnv/bin/activate
```

Once the virtual environment is activated, you may notice that you prompt in the terminal change to have the word `KennywoodEnv` either in parenthesis or has the word `via` before it.

## Installed Required Packages

Now you use pip to install all of the packages needed for this project.

```sh
pip install django autopep8 pylint djangorestframework django-cors-headers pylint-django
```

Once they are installed, you use the `freeze` command to capture all of the packages, and their version numbers, in a file so that other developers can easily install those requirements on their machine.

```sh
pip freeze > requirements.txt
```

## Allowing Common Variables Names

The pylint package is very good at ensuring that you follow the community standards for variable naming, but there are certain times that you want to use variable names that are short and don't use snake case. You can put those variable names in a `.pylintrc` file in your project.

Without this configuration, your editor will put orange squiggles under those variable names to alert you that you violated community standards. It becomes annoying, so you override the default rules.

```sh
echo '[FORMAT]
good-names=i,j,ex,pk
' > .pylintrc
```

In Visual Studio Code, `cmd+shift+p` and open "Preferences: Open Settings (JSON)". Add the following configuration item to the object.

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django"
],
```

## Create Base Django Tables

You may remember that Django gives you user and role management tables out of the box, and there is a built-in migration file that makes the tables for you. Go ahead and run that migration to set up the initial Django tables.

```sh
python manage.py migrate
```

Move on to the next chapter to create your API application in this project.