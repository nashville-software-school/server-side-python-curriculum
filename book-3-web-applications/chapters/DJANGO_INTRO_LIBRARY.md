# First Django Project: Nashville Public Library

## Goals

The purpose of this application is to allow librarians to manage the books in their library's inventory. The user will be able to add new books, remove obsolete books, and mark when a book has been checked out by a patron or checked back in.

### Design Data Relationships

Time to deconstruct this problem into what you need to build in our application. First, you need to define the tables and relationships you will need in your database.

* Libraries
* Books
* Librarians _(the users)_

Now take some time to create an ERD of this database structure on [dbdiagram.io](https://dbdiagram.io).

## Virtual Environment Setup

```sh
mkdir -p ~/workspace/python/library-management && cd $_
python -m venv libraryenv
source ./libraryenv/bin/activate
pip install django
pip freeze > requirements.txt
```

## Create Django Project

Django creates a project directory. A project can have 1 -> _n_ applications contained within in. For example, you could have a project for managing a coffee shop. The project could contain an application that is for the people who work at the coffee shop to maintain inventory, payroll and financials. The project could also contain an application for the public website that customers can use to buy products.

This project is going to start with only one application.

```sh
django-admin startproject libraryproject
cd libraryproject
```

When you tell Django to create a project, it automatically generates an administrative application that you can use to manage data in the database, set up users, etc. Every Django project starts with this administrative application. You then have to create another application for what you want to build.

Right now, you should see `library-management/libraryproject/libraryproject` directory. That nested `libraryproject` directory is the administrative application.

## Create Super User

Be in the `library-management/libraryproject` directory, and run the following command. Enter in whatever credentials you want to use for your super user account.

```sh
python manage.py createsuperuser
```

This account will allow you to use the web-based administration site that Django provides. You'll learn more about this later.

## Create Nashville Library Application

Your application's purpose is to manage the libraries, librarians and books, so you will create a Django application with an appropriate name. Make the name of the app one word and all lower case. Do not use spaces. Do not use dashes. Do not use underscores.

Then you will run what's called a database migration. The `migrate` command you see below will create the database for your application, and create a set of tables that Django uses for user management.

```sh
python manage.py startapp libraryapp
python manage.py migrate
cd libraryapp
```

## Add the Library Application to INSTALLED_APPS

Open your `settings.py` file and make sure your `libraryapp` application is in the list of apps.

```py
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'libraryapp'
]
```

## Create Models

First, create a `models` sub-directory in your `libraryapp` directory. Then create all the files needed for this package. Having the `__init__.py` import all of the classes from the other modules is necessary.

> **Note:** You will notice a `libraryapp/models.py` file that gets automatically generated for your application. You will not be using that file, and can delete it.

```sh
md models && cd $_
touch library.py book.py librarian __init__.py
echo 'from .library import Library
from .book import Book
from .librarian import Librarian
' >> __init__.py
```

Now that all of the files are created, it's time to define all of the models. Each model must define a property for each column you want in the corresponding database table that it will create.

### Library Model

Open `library.py` and use the power of your Python extensions to add the `from django.db import models` at the top of the files. This import is needed for Python classes that are modeling a database table.

![import django db models](./images/model-import-generator.gif)

Then create a new class with another code generator. Type in `Model` and select that item from the suggested list.

The code generator will erroneously put underscores before the verbose meta fields. Delete those.

![class generator example for animal types](./images/class-generator.gif)

Then create the properties for the class. There are also code generators for those. The code generator produces an initial argument with an underscore at the beginning with two quotes inside parenthesis. You can delete that entire first argument.

![property generator example](./images/property-generator.gif)

Now you can define the models for a patron, and a library.

### Book Model

> **Lightning Exercise:** It's your job to create a Book model in the `book.py` module. A book should have the following properties.
>    * Title
>    * ISBN number
>    * Author
>    * Year published

## Creating Relationships Between Models

Now that you have a **`Library`** model and a **`Book`** model, it's time to define the relationship between them. If two models are related, you open the model that represents the table with the foreign key and add a `ForeignKey` field. Since the book table has a foreign key to the library table, then open up your `book.py` module and add the following foreign key to it.

```py
location = models.ForeignKey(Library, on_delete=models.CASCADE)
```

Now each book will have a `location` property on it, and it stores the primary key of one of the libraries.

## Assigning Data to Users

Django has a namespace `django.contrib.auth.models` that you can use to utilize its built-in user authentication and authorization system. In your application, librarians will register new accounts and be able to manage which library they are assigned to, add/remove books, and assign books to libraries.

Each user should only be able to access data that they created, and not other people's data. Since each user will be creating a farm, and then assigning animals and facilities to it, we need to assign farms to users.

1. Open `farm.py`.
1. Import models like all the other classes.
1. Then include `from django.contrib.auth.models import User` as the next import.
1. Use the Model code generator to create the `Farm` class.
1. Define a `name` property of type `CharField` and a `date_create` property of type `DateField`.
1. Then define a `user` property that is a `ForeignKey` to the `User` class that you imported from Django.

![](./images/farm-model.gif)

## Related Type Attribute

When any model has a foreign key to another model, you can specify a `related_name` attribute on that property. For example, the **`Animal`** model has a foreign key to both the **`Facility`** and **`AnimalType`** model. This allows you to use the Django ORM to easily select sets of data.

Change your **`Animal`** class foreign key properties to the following.

```py

```