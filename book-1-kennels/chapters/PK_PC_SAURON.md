# More Abstractions and DRY Code

The code in the `request_handler` module isn't the only place you may have noticed that the same code is written over and over again. If you look at the modules that handle getting the data, they code is pretty much identical. The only difference is the name of the variable that contains the list of dictionaries.

Your challenge in this Pioneer chapter is to consolidate the code from ALL of those modules into a single one. It will contain all of the data in a new mega-structure, and will use generically named functions that rely on parameters to know which data to get.

In order to save all of your existing code as is, we recommend you take the following steps first.

```sh
cp request_handler.py server.py
touch repository.py
```

All of your new code will be in these two files. The `repository` module will contain all of the data, and five functions.

1. `all()` - To get all of a resource
1. `retrieve()` - To get a single resource
1. `update()` - To change a single resource
1. `delete()` - To delete a single resource
1. `create()` - To create a new resource

You must determine how many parameters are needed for each function to do its job correctly, and how to access the correct resource in the database.

```py
DATABASE = { }


def all():
    """For GET requests to collection"""
    pass


def retrieve():
    """For GET requests to a single resource"""
    pass


def create():
    """For POST requests to a collection"""
    pass


def update():
    """For PUT requests to a single resource"""
    pass


def delete():
    """For DELETE requests to a single resource"""
    pass
```
