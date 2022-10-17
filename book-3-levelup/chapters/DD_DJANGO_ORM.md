# Object Relational Mapper Tools

The Django framework comes with a built-in tool that allows you to interact with your database without the need for SQL. Most modern application frameworks come with a tool like this. It's called an Object Relational Mapper - or ORM for short.

The Djano ORM has many powerful features, but we're going to start with the fundamentals - basic CRUD.

* Selecting all rows from a table
* Selecting a single row from a table
* Inserting a new row into a table
* Deleting a row from a table
* Updating a row in a table

## Selecting all Cities

Using the Django ORM, you would write the follow Python code. It will return a collection of objects that represent each row in the table.

```py
cities = City.objects.all()
```

## Selecting a Single City

With the ORM, you use the `get()` method instead of `all()`. This ensures that a single row will be returned. You provide the condition as the argument to the `get()` method.

The `pk` below means primary key. You will use that in Django when you want to reference the `id` column.

```py
city = City.objects.get(pk=2)
```

## Creating a New City

With the ORM, you use the handy `save()` method on a newly created instance of the database model once all the properties have been given a value.

```py
city = City()
city.name = 'Albuquerque'
city.save()
```

## Deleting a City

First, you tell the ORM which row should be deleted by using `get()` and then immediately use the `delete()` method to remove it from the table.

```py
city = City.objects.get(pk=2)
city.delete()
```

## Updating a City

Imagine that you spelled Denver wrong on the initial insert. You spelled it "Deenver" with an extra `e`. The process is the combination of `get()` and `save()`. In between, you give a new value to any property.

```py
city = City.objects.get(name='Deenver')
city.name = 'Denver'
city.save()
```

## Next Steps

Now that you have seen how the Django ORM provides you with abstractions for basic SQL operations, move to the next chapter and see how these methods are used in Django Views.