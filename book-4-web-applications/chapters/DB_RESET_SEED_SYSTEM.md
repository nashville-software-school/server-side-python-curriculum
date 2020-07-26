# The Nuclear Option: Or How I Stopped Worrying and Learned to Love Blowing Up My Database

As you work through the Bangazon assignments you will quickly discover that SQLite doesn't handle migrations all that well. Inevitably, if you create more than one migration file it will choke.

The best solution for now, to keep you moving forward and not losing precious sprint days, is to blow up your db and migration folder every time you need to change your models/db schema. It's easy enough to manually delete those, but if you've created data for that db, it goes bye-bye.

The following is an automated way of nuking your migrations and db, recreating your migration file and db, and repopulating (most*) tables. It consists of a shell script and a file to add to any Django project where you will be using SQLite and migrations:

1. ## The custom manage.py command:

In any Django app folder that contains migrations, create a `management` directory. Inside that directory create an empty `__init__.py` file and a `commands` directory. Then inside `commands` create an empty `__init__.py` file and a file called `faker_factory.py`. Paste this code into it:

```python
from django.core.management.base import BaseCommand
from django_seed import Seed
seeder = Seed.seeder()
import random
from product_api.models import Customer, Payment_Type, Product_Type, Product

class Command(BaseCommand):

  def handle(self, *args, **options):
    seeder.add_entity(Product_Type, 12) # the number argument is the total num of rows you want created
    seeder.add_entity(Customer, 25)
    seeder.add_entity(Payment_Type, 50, {'acct_number': lambda x: random.randint(11111,99999)})
    # Override the seeder "guess" of what faker provider you want it to use
    seeder.add_entity(Product, 100, {'name': lambda x: seeder.faker.catch_phrase()})

    inserted_pks = seeder.execute()
```

You'll need to `pip install django_seed`, a third-party module that does the heavy lifting of creating fake data to populate your tables.

Review django_seed's docs for the types of data it's capable of generating for you, then customise the `handle` method to suit your project's models.

2. ## The shell script
You _can_ manually delete the db stuff, then directly run the custom command file above, but where's the fun in that? Saving this script where you can run everything with one command is heaps more bad-ass.
>For Mac users, save this file as `django_data.sh` in `usr/local/bin` (Which is at your machine's root, not your Users folder)

>For non-Mac users, try just saving it locally at the project root and running it with `./django_data.sh <arg1> <arg2>`

```bash
#!/bin/bash

find . -path "./$1/migrations/*.py" -not -name "__init__.py" -delete; #deletes all of the .py files in the migrations directory except for the __init__.py file.
find . -path "./$1/migrations/*.pyc"  -delete; #deletes all of the .pyc files in the migrations directory.
rm db.sqlite3; #deletes the database file.
python manage.py makemigrations $1; #creates the migration and the new db file.
python manage.py migrate; #runs the migration.
python manage.py $2 #runs the custom command to generate fake data and populate your tables with it
```

You will need to change the permissions of this file with `chmod +x django_data.sh` to make it executable.

Now you can run it with two args:
1. The name of the django app that contains the models you want to add to the db schema/update
2. The name of the custom command file. If my app was called bangazon_api, then I would type

    > `django_data.sh bangazon_api faker_factory`


*NOTE: This process will only work properly for data that doesn't contain foreign keys. You will need to create those table entries manually. But at least the base data will be there for you to access when you save new orders or assign employees to training classes.

*NOTE 2: This is tested on exacly one machine, so consider it experimental :)
If it doesn't work, come see an instructor and we'll see if we can make it run properly together.
