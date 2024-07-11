# Model Classes

Django uses special classes to interact with the database. They are called _Models_. For every table that you have in your database, you are going to create a corresponding module and class in your `models` directory.

Open the `models/city.py` module to see how a database model class is defined. This is a fairly simple model since the database table for cities only has two properties.

* `id`
* `name`

You'll notice that only the name property is defined in the class. This is because when you generate a table from a database model, Django will automatically create the `id` column, make it the primary key, and set it to autoincrement whenever a new row is inserted.

It's pretty handy... as long as you remember that it does it for you. Many a beginner defined the `id` field in their model class and ended up with 2 in the table.

```py
from django.db import models  # Import base class from Django stdlib


class City(models.Model):  # Must inherit from this base class
    name = models.CharField(max_length=155)  # Define all non-id fields
```

## Appointments Model

That's right. You are going to create your first Django model class!

DeShawn wants to start tracking when the walkers are scheduled to walk a dog. You need to track the following information.

* The walker
* The date of the walking appointment
* If the appointment was kept

### Updating the ERD

That means that you need to add the following table to your ERD.

| Field | Type |
|--|--|
| id | int |
| walker_id | int |
| date | datetime |
| completed | bool |

Once you update your ERD, it's time to create a model class so that your Django application can perform operations with it.

### Creating the Module and Class

Create a new `models/appointment.py` module. Then add the following code inside it.

```py
"""Appointment database model module"""
from django.db import models


class Appointment(models.Model):
    """Database model for tracking walker appointments"""
    completed = models.BooleanField(default=False)
    date = models.DateField()
    walker = models.ForeignKey('Walker', on_delete=models.CASCADE, related_name='appointments')
```

Here are some common things that beginners notice.

1. To create a `walker_id` foreign key field, you don't need to put `_id` in the class definition. Django does that for you.
2. The `default` argument will automatically set the value to 0 when a new row is inserted, making it optional on creation.
4. The `'Walker'` argument for the foreign key field is the name of the related class.

## Update Models Package

Open the `models/__init__.py` module and add your new class to the package.

```py
from .appointment import Appointment
```

## Next Steps

Now that you have defined the database model, you have completed the first step toward performing a task called a database migration. There are a few more steps before you can do it.

| Term | Definition |
| --| --|
| Migration | A fancy word that software developers use for running an automated script that changes the structure, or data, of a database. |

Move to the next chapter to be introduced to a tool in Django called the ORM. It will replace the use for writing SQL statements by providing abstractions to the basic CRUD operations.
