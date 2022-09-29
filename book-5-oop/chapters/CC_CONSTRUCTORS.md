# Condensed Critter Construction

In this chapter you will learn how to assign values to an object instance of a class on the same line of code where it is created, rather the the verbose process you are using now of...

```py
george = Monkey()
george.name = "George"
george.species = "Howler Monkey"
```

Instead of 3 lines of code to fully define George, you'll do it in one line of code by using a **_Class Constructor_**.

## Class Construction Arguments

The `__init__()` method on any Python class allows you to do the condensed syntax. The method automatically run as soon as you create an instance. It can accept as many arguments as you like. Those arguments can then be used to initialize the properties of each object created from the class. Here's an example.

```py
class Pig:

    def __init__(self, name, species):
        self.name = name
        self.species = species
        self.date_added = date.today()
        self.walking = True

wilbur = Pig("Wilbur", "pot-bellied pig")
```

By passing the property value in during the instantiation of the object, you don't have to manually create the properties on a separate line of code.


## Practice: Update Yer Critters Construction

Refactor your critter classes to make your `__init__` method accept two arguments

1. `name`
2. `species`

Once defined this way, you can send those values as arguments when you create each instance.
