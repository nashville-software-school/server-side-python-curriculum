# Python Classes

A class in Python is much like the new instances of functions that you created in JavaScript when you learned about prototypal inheritance.

Instead of using the `new` keyword, or using the newer `Object.create()` function, you simply define a class and call it like you were calling a function. Below is a perfectly valid class (that does absolutely nothing) and then gets created and invoked afterwards.

```python
# Define a class
class noop:
    pass  # Pass means "Move along, please. Nothing to see here."

# Create an instance of the class and invoke it
noop()
```

What exactly gets invoked in this case since the class has no actual logic in it. For any class, when you invoke it, it executes the `__init__` method. Since our simplistic example above didn't define any logic for the built-in `__init__` method, nothing happened.

## Simple Class

Let's define a class that actually does something when it's initialized.

```python
class Zoo:
    def __init__(self, name):
        self.zoo_name = name

a_zoo = Zoo("Zoolandia")
a_zoo.zoo_name
```

You can see that the syntax is very close to creating a new instance of a JavaScript class. Be aware that the `__init__` function may **look** like the constructor function, but it's not. It only gets invoked after the instance of the class has been fully created, and that new instance gets passed into the `__init__` function.

In fact, the class instance is the first argument to **_any_** function defined in a class.

```python

class Zoo:
    """Contains methods for maintaining a Zoo

    Methods:
    --------
    build_habitat
    sell_family_ticket
    purchase_animal
    """
    def __init__(self, name):
        self.zoo_name = name
        self.animals = dict()
        self.habitats = set()
        self.visitors = list()


    def build_habitat(self, name, type):
        """Adds tuples to the habitats set in the format (name, type)

        Method arguments:
        -----------------
        name(string) -- The marketing name of the habitat
        type(string) -- The type of habitat (e.g. Saltwater, Savanna, Swamp, etc.)
        """

        self.habitats.add((name, type))


    def sell_family_ticket(self, family):
        """Adds an entire family to the list of visitors

        Method argument:
        -----------------
        family(list) -- A list of people in a family of visitors
        """

        self.visitors.extend(family)


    def purchase_animal(self, type, name):
        """Add an animal to the zoo

        Method arguments:
        -----------------
        type(string) -- The type of animal to add
        name(string) -- The given name of the animal
        """

        self.animals[name] = type


    def list_animals(self):
        """Lists all animals in the zoo

        Method arguments:
        n/a
        """

        [print(k + ' the ' + v) for k, v in self.animals.items()]


a_zoo = Zoo("Zoolandia")
a_zoo.add_animal("Tortoise", "Tommy")
a_zoo.list_animals()

a_zoo.list_animals.__doc__ # To view the docstring for the method
```

## Subclassing

In the previous example, we used strings to define an animal. Let's be more detailed in what an animal is by defining an `Animal` class.

```python
class Animal:
    def __init__(self, name = None, species = None):
        self.name = name
        self.species = species
        self.speed = 0
        self.legs = 0

    def getName(self):
        return self.name

    def walk(self):
        print("Parent class walk method")
        self.speed = self.speed + (0.1 * self.legs)

    def setSpecies(self, species):
        self.species = species

    def getSpecies(self):
        return self.species

    # __str__ is a special function equivalent to toString() in JavaScript
    def __str__(self):
        return "%s is a %s" % (self.name, self.species)


class Dog(Animal):
    def __init__(self, name):
        Animal.__init__(self, name, "Dog")

    def walk(self):
        self.speed = self.speed + (0.2 * self.legs)
```

    

# Additional Reading

1. [An Introduction to Python Classes and Inheritance](http://www.jesshamrick.com/2011/05/18/an-introduction-to-classes-and-inheritance-in-python/)