# DRF Installations and Configuration

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

Django gives user and role management tables for your application out of the box, and there is a built-in migration file that makes the tables in a SQLite database for you. Go ahead and run that migration to set up the initial tables.

```sh
python manage.py migrate
```

Move on to the next chapter to create your API application in this project.