# First Django Project: Trestlebridge Farms

## Goals

The purpose of this application is to do basic management of farms. We're going to define some different areas of each farm - called facilities - that will contain animals that we will purchase. Certain facilities will only be able to hold certain animals. You need to record when an animal was purchased, when the farm was established, and when a new facility is constructed on a farm.

We will be purchasing the following animals.

* Pigs
* Cows
* Chickens
* Llamas

Pigs will be put in pig pens.

Cows and llamas will be put in grazing fields.

Chickens will be put in chicken coops.

### Design Data Relationships

Time to deconstruct this problem into what you need to build in our application. First, you need to define the tables and relationships you will need in your database.

* Farm (id, name, date_created)
* Facilities (id, date_constructed, farm_id)
* Facility types (id, description)
* Animals (id, date_purchased, facility_id)
* Animal types (id, description)



## Virtual Environment Setup

```sh
mkdir -p ~/workspace/python/trestlebridge
python -m venv env
source ./env/bin/activate
pip install django
pip freeze > requirements.txt
```

## Create Django Project

Django creates a project directory. A project can have 1 -> _n_ applications contained within in. For example, you could have a project for managing a coffee shop. The project could contain an application that is for the people who work at the coffee shop to maintain inventory, payroll and financials. The main project could also contain an application for the public website that customers can use to buy products.

```sh
django-admin startproject farmproject
```

When you tell Django to create a project, it automatically generates an application that you can use, as the administrator, to manage data in the database, set up users, etc. Every Django project starts with this administrative application. You then have to create another application for what you want to build.

## Create Trestlebridge Application

Your application's purpose is to manage the facilities and animals on the farm, so create a Django application with an appropriate name. Make the name of the app one word and all lower case. Do not use spaces. Do not use dashes. Do not use underscores.

```sh
python manage.py startapp inventoryapp
```

