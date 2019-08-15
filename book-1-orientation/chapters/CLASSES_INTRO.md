# Classes
Much like Javascript, almost everything in Python is based on objects. The ability to create objects in a predictable, organized way is essential. This is where classes come into play.

A class is like an object constructor, or a blueprint for creating objects. It helps us define the representation of something from the real world, in code. That 'something' is defined by its values and behaviors (properties).

Once a class is defined, we can use it to crank out objects based on the class. We call those objects _instances_ of the class.

To define a class, we begin with the keyword _class_

```python
# Define a class
class noop:
    # In here we define the properties of the class
```
To create an instance of the class, we simply invoke it
```python
noop()
```

For any class, when you invoke it ( `noop()` ), it executes an internal `__init__` method. In this method, we can define properties that every instance of the class will contain

```python
# define the Class
class Zoo:
    def __init__(self, name):
        self.zoo_name = name

# instantiate the class
nash_zoo = Zoo("Nashville Zoo")
# log out the name. Will print "Nashville Zoo"
nash_zoo.zoo_name
```

What's up with that _self_ parameter? `__init__` gets invoked after the instance of the class has been fully created, and that new instance gets passed into the `__init__` function.

In fact, the class instance is the first argument to **_any_** function defined in a class.

Let's take the zoo class to a new level, complete with values and behaviors.
```python

class Zoo:
    """Contains methods for maintaining a Zoo

    Methods:
    --------
    build_habitat
    sell_family_ticket
    purchase_animal
    """

    # define the beginning values of all zoo instances
    def __init__(self, name):
        self.zoo_name = name
        self.animals = dict()
        self.habitats = set()
        self.visitors = list()

    # define the methods that allow the zoo to do things
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

# Instantiate our zoo and use its behaviors to update its values; then get those values out of it
nash_zoo = Zoo("Nashville Zoo")
nash_zoo.purchase_animal("Tortoise", "Tommy")
nash_zoo.list_animals()

print(nash_zoo.list_animals.__doc__) # To view the docstring for the method
```

## Practice: A class is like a blueprint
## Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch classes.py
```

## Instructions
1. Create a class for making pizzas. Think about some basic properties that would define a pizza's values; things like size, crust type, and toppings would help. Define those in the `__init__` method so each instance can have its own specific values for those properties.

2. Add a method for interacting with a pizza's toppings, called `addTopping`, and a method for outputting a description of the pizza.

3. Make two different instances of a pizza. If you have properly constructed the class, you should be able to do something like this...

```python
meat_lovers = Pizza("16", "deep-dish")
meat_lovers.addTopping("pepperoni")
meat_lovers.print_order()
```
...and get this result in the terminal: "I would like a 16-inch, deep-dish pepperoni pizza."


## Practice: Companies and Employees
## Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees.py
```

## Instructions

1. Create an Employee class that contains information about employees of a company and define methods to get/set employee name, job title, and start date.

2. Copy this `Company` class into your module.

    ```
    class Company(object):
        """This represents a company in which people work"""

        def __init__(self, company_name, date_founded):
            self.company_name = company_name
            self.date_founded = date_founded

        def get_company_name(self):
            """Returns the name of the company"""

            return self.company_name

        # Add the remaining methods to fill the requirements below
    ```

3. Consider the concept of [aggregation](../FND_11_INHERIT_COMPOSE_AGGREGATE.md#aggregation), and modify the `Company` class so that you assign employees to a company.
4. Create a company, and three employees, and then assign the employees to the company.
