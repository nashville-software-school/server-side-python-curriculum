# Solving Transient Changes

Changes that you make to your resources up to this point have been transient - meaning that as soon as the Python server restarts when you make changes to you code, the resources revert back to their initial state.

It's time to store your data in a database.

The first step in that process is to switch from using raw, Python lists and dictionaries to using custom types, or classes, to represent the resources.

## Learning Objectives

* You should be able to identify a custom type _(i.e. a class)_ in Python code.
* You should be able to identify how a method is defined in a class.
* You should be able to identify a class initializer method.
* You should be able to implement a class, with methods, in Python.

## Video Resources

* [Python 3's __init__(), self, Class and Instance Objects Explained Concisely](https://www.youtube.com/watch?v=AsafkCAJpJ0&t=177s)
* [Python Classes and Objects || Python Tutorial](https://www.youtube.com/watch?v=apACNr7DC_s)

## Animal Class

Time to write your first class that will serve as a blueprint for all objects that get created for an animal.

Here is your first blueprint. It simply defines what properties will be on an object representation of an animal.

The class itself does not create anything. It's just the design. Note that there is a class property for each key that you have on the animal dictionaries that are currently hard-coded in your `ANIMALS` list.

```py
class Animal():

    # Class initializer. It has 5 custom parameters, with the
    # special `self` parameter that every method on a class
    # needs as the first parameter.
    def __init__(self, id, name, species, status, location_id, customer_id):
        self.id = id
        self.name = name
        self.species = species
        self.status = status
        self.location_id = location_id
        self.customer_id = customer_id
```

Now, to create a new Python object **based** on that class, you would write the following code.

```py
new_animal = Animal(1, "Snickers", "Dog", "Recreation", 1, 4)
```

It looks very much like invoking a function, and there are many similarities. Just like functions - which themselves are a definition of a plan - classes define how an object will look.

Functions need to be invoked for the plan to run. Classes need to be **_instantiated_** to create an object from its design.

## Models Package

Create a new directory in your project named `models`.

Inside that directory, create a file named `animal.py`.

Open the file and copy pasta the **`Animal`** class definition from above into the module.

Create an `models/__init__.py` file to have a **models** package, and import the class into the package.

```py
from .animal import Animal
```

## Location, Employee and Customer Models

Create three new modules in the `models` directory.

1. `customer.py`
1. `employee.py`
1. `location.py`

In each one create a class for the corresponding resources. Look at all of the properties that you currently have on the hard-coded dictionaries and make a matching property on the class.

For example, locations have an `address` property. That means that the **`Location`** class should have that same property.

```py
class Location:

    def __init__(self, id, address):
        self.id = id
        self.address = address
```

When you are happy with your classes, import them into the package `__init__.py` module.

## What's Next

Now that you have classes to represent each resource for your application, it's time to move on to the next chapter and learn how to set up a database. You will start learning the SQL language to extract data from a relational database, and then use that data to create instances of the classes that you just defined.
