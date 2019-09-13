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

## API Application

Now that the project is set up and has some initial configuration, it's time to create your application for the API you are building.

```sh
python manage.py startapp kennywoodapi
```

Now you need to update your application settings to enable Django REST Framework, CORS headers, and your application. Replace the following section in your `settings.py` file with the code below.

> ##### `settings.py`

```sh
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
    'kennywoodapi',
]
```

## First Run

Now you can start the project and verify that everything was configured correctly.

```sh
python manage.py runserver
```

Then open the URL of `http://127.0.0.1:8000/` in your browser and you should see a web page with no errors on it. If you do see error, please visit the instruction team.

## Defining Model Package and Modules

Next, create the `models` directory and the initial files that will contain the individual Models for the application.

```sh
mkdir models && cd $_
touch __init__.py customer.py attraction.py parkarea.py
echo 'from .customer import Customer
from .attraction import Attraction
from .parkarea import ParkArea' >> __init__.py
```

## Defining the Views Package

Now create a views directory and the file needed to make it a package.

```sh
cd ..
mkdir views
touch views/__init__.py
```

## Park Area Model

In this application, customers are going to build an itinerary of attractions that they want to visit at Kennywood. Each attraction is assgined to a specific area of the park, and each area has a particular theme.

```py
"""Module for Park Areas"""
from django.db import models


class ParkArea(models.Model):
    """Model class for ParkArea"""
    name = models.CharField(max_length=50)
    theme = models.CharField(max_length=50)

    class Meta:
        verbose_name = ("parkarea")
        verbose_name_plural = ("parkareas")

    def __str__(self):
        return self.name
```

## Park Area View and Serializer

You are going to be using an abstraction in the Django REST Framework library called a `ViewSet`. This particular type allows you to write more abstract code than you did for your first Django exercises and project.

You will also be using another built-in type called a `HyperlinkedModelSerializer`. What this class does is take a Python object and convert it into JSON for you, **and** adds a virtual property of `url` to the resulting JSON.

The `ViewSet` class allows you to write logic for the operations that can be performed on a resource in the API. The first operation you will handle is a client requesting all park areas. For this operation, the `ViewSet` exposes a `list()` method. Your logic goes in that method.

```py
"""View module for handling requests about park areas"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers
from rest_framework import status
from kennywoodapi.models import ParkArea


class ParkAreaSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for park areas

    Arguments:
        serializers.HyperlinkedModelSerializer
    """
    class Meta:
        model = ParkArea
        url = serializers.HyperlinkedIdentityField(
            view_name='parkarea',
            lookup_field='id'
        )
        fields = ('id', 'url', 'name', 'theme')


class ListParkAreas(ViewSet):
    """View class for handling requests about park areas"""

    def list(self, request):
        """Handle GET requests to park areas resource

        Returns:
            Response -- JSON serialized list of park areas
        """
        areas = ParkArea.objects.all()
        serializer = ParkAreaSerializer(
            areas,
            many=True,
            context={'request': request}
        )
        return Response(serializer.data)
```

## Django ORM

Wait, wait, wait! What the heck is `ParkArea.objects.all()`????

It's an abstraction that the Object Relational Mapper (ORM) in Django provides that queries the table holding all the park areas, and returns every row. It is the equivalent of you explicitly writing the following SQL.

```sql
SELECT
    pa.id,
    pa.name,
    pa.theme
FROM kennywoodapi_parkarea pa
```

Django will now write that SQL _**for you**_.
