# Karen's Level Up Requirements

## Meeting Karen

> Insert dialogue here



## Design Models

Now that the application has been configured correctly, it's time to start designing your database. In Django, you use model classes instead of writing `CREATE TABLE` SQL statements.

Here is a quick example.

Imagine that you want to create a table in your database to store information about toys. These toys have a few properties.

* Color
* Price
* Material
* Name

In SQL, you would write the following SQL statement to create the table.

```sql
CREATE TABLE `Toy` (
	`id`	    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	    TEXT NOT NULL,
	`material`	TEXT NOT NULL
	`color` 	TEXT NOT NULL
	`price` 	FLOAT NOT NULL
);
```

Django can do that for you without ever needing to write SQL. You write classes that act as database models. You even get to leave out the `id` field. Django will add that automatically.

```py
from django.db import models

class Toy(models.Model):
    name = models.CharField(max_length=55)
    material = models.CharField(max_length=55)
    color = models.CharField(max_length=12)
    price = models.DecimalField(max_length=7,decimal_places=2)
```



> Insert narrative for meeting Karen and her stumbling walkthrough of what she wants.

1. Django Users
1. Gamers with 1 -> 1 to Users
1. Game types
1. Gamer games
1. Gamer events
1. GamerEvents &infin; -> &infin; model
1. import all models to `__init__.py`

## Migration of app models

```sh
python manage.py makemigrations levelupapi
```
