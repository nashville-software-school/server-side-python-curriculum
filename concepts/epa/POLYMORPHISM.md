# Polymorphism

[Polymorphism](https://en.wikipedia.org/wiki/Polymorphism_(computer_science)) means that different objects may share the same set of properties and methods, but each may use those properties and methods to achieve different behavior.

# Polymorphism via Subtyping

For example, in a base class of Animal, you define a general rule of how fast an Animal can walk. However, in the derived Lizard class, you can override that rule to give Lizards a slightly different behavior. For every leg they have, they can move twice as fast as a generic Animal.

This is subclass polymorphism - achieved with inheritance. Both `Dog` and `Animal` are typed as `Animal` so you have the same type exhibiting different behaviors.

```python
class Animal:
    def __init__(self, name = None, species = None):
        self.name = name
        self.species = species
        self.speed = 0
        self.legs = 0

    def walk(self):
        print("Parent class walk method")
        self.speed = self.speed + (0.1 * self.legs)

    def __str__(self):
        return "%s is a %s" % (self.name, self.species)

class Dog(Animal):
    def __init__(self, name):
        Animal.__init__(name, "Dog")

    # Override the parent method to add more functionality
    def walk(self):
        self.speed = self.speed + (0.2 * self.legs)
```

In Python, you can use the `super()` method, which allows a derived class to invoke the corresponding method in the parent class, possibly modifying its inputs or outputs before returning.

```python
class Animal:
    def __init__(self, name = None, species = None):
        self.name = name
        self.species = species

    def eat_food(self, food):
        return "{0} eats {1}".format(self.name, food)

class Panda(Animal):
    def __init__(self, name):
        super().__init__(name, "Panda")

    # The eat_food method's behavior is derived from the parent
    # class, but is made more specialized in the derived class
    def eat_food(self, food):
        parent_message = super(Panda, self).eat_food(food)
        message = ' '.join([parent_message, "but doesn't digest it very well"])
        return message
```

# Ad Hoc Polymorphism

There is another kind of polymorphism that is achieved by method overloading. What this means is that a method on a class can behave differently based on it signature. In Python, you achieve this via named method arguments with default values.

Here's an example.

```py
class Building:

  # Even though the method is defined once, the named arguments
  # with default values actually produces multiple signatures
  def collapse(source=None, site=None)
    if source is None:
      reason = "for no apparent reason"
    else:
      reason = "because a " + source + " hit it"

    if site is None:
      site = "into nothing"
    else:
      site = "into " + site

    return "The building collapsed {} {}".format(site, reason)


# Create an instance of the class
leaning_tower = Building()

# Method signature #1
leaning_tower.collapse(source="gust of wind")

# Method signature #2
leaning_tower.collapse(site="a lagoon")

# Method signature #3
leaning_tower.collapse(site="the sidewalk", source="flock of birds")
```

# Resources

* [Method overriding](http://blog.thedigitalcatonline.com/blog/2014/05/19/method-overriding-in-python/) in Python
* [Object oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming)