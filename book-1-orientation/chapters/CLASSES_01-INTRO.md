# Classes
<!-- Intro to classes
Intro petting zoo
~20 different animal classes w/ name, species, date_added -->

## Why are you Learning This?

You are learning about the syntax and usage of classes because when you extract data from a relational database later in the course, each row of data represents the state of certain things, such as a student, a building, a book, or any other real-world object that you want to store data about.

Classes let you define your own, custom type in Python. The current types that you know about are `list`, `dict`, and `set`. These data structure types are very limiting when you need to represent a complex object in code, though.

## Introduction to Classes

Much like Javascript, almost everything in Python is based on objects. The ability to create objects in a predictable, organized way is essential. This is where classes come into play.

A class is like an object constructor, or a blueprint for creating objects. It helps us define the representation of something from the real world, in code. That 'something' is defined by its values and behaviors (properties).

Once a class is defined, you can use it to crank out objects based on the class. We call those objects _instances_ of the class.

![visualization of two instances of the Student class](./images/python-class-instances.png)

To define a class, you begin with the keyword `class` and then define at least an `__init__` method on for the class. The `__init__` method holds the instructions for what to do when a developer makes an instance of your class.

<!-- NEW stuff -->
## Critters and Croquettes Petting Zoo and Tapas Bar

Lets build some classes for a business that's poised to become the #1 tourist trap in Gatlinburg: Critter and Croquettes Petting Zoo and Tapas Bar. Owner Bobby Andrew Kawlins has big plans for his business, starting with improving how he keeps records of his animals. As the newest member of the dev team, you want to really get a sense of what our new client needs, so you take a drive to Gatlinburg to sit down with Bobby in his office...

> Perched on a hill just down the street from Hillbilly Golf and Ripley's Believe it or Not, Critters and Croquettes Petting Zoo and Tapas Bar smells like new paint and carpet mixed with goats and chickens. Bobby is animated, full of ideas, and excited to have an app that will help him manage his growing empire.
>
> "My market research tells me people are crying out for a place where they can eat like hipsters and feed miniature goats at the same time," Bobby tells you. "Right now I have a handful of critters, but the plan is to add more; a lot more. Nobody wants to stand in line to scratch a donkey's ears, you know?"
>
> You nod and smile. "Sounds great," you say. "So, sounds like you want to be able to keep records of your current animals, but also be able to add more as you acquire them."
>
> "Exactly!" says Bobby.

To help Bobby with that, we know we're going to need to represent animals in his petting zoo with our Python code. Each animal will have properties such as name, species, and year it was added to the zoo.




Here's how you would define a template for how each animal will be represented in the application.

```py
# import the python datetime module to help us create a timestamp
from datetime import date

class Animal:

    def __init__(self):
        # Establish the properties of each animal
        # with a default value
        self.name = ""
        self.species = ""
        self.date_added = date.today()
```

Remember, this class is not an animal itself. It's just a mechanism for creating animal objects. To create an instance of the class, you type the name of the class and put parenthesis after it. You should always store the object instance in a variable.

```py
goat = Animal()
```

For any class, when you create an instance of it, it executes an internal `__init__` method. In this method, one common thing to do is to define properties that every instance of the class will contain. Time to examine what the value of each of our book's properties are.

> **Tip:** What's up with that _self_ parameter that is the first argument of the `__init__` method? It's the instance of the class that you created.

If you were to loop over the goat object you created...

```py
for prop, value in goat.__dict__.items():
    print(f'{prop}:\n{value}\n')
```

...you would see the following output:

```py
name:


species:


date_added: "2020-06-16" # or whatever the date is when you create the instance of Animal

```

Update the object by defining the values for the name and species properties.

```py
goat.name = "Bucky"
goat.species = "miniature goat"
```

Now looping over the goat object would produce the following output.

```py
name:
Bucky

species:
miniature goat

date_added: "2020-06-16"
```
> "Hello? Hey there, hello?"
>
> You snap out of your reverie, and realize you zoned out thinking about class syntax in Python. "Sorry", you say. "I was just...uh...already picturing how to build your app."
>
> Bobby smiles his infectious grin. "Oh, I understand completely. I could dream about pot-bellied pigs and pan tumaca all day, myself!"
>
> After a quick tour of the petting corral and a bite of cheese sampler, on the house, you head back to the office to get started

<!-- TODO: Move exercises to supplementary chapter? -->
### Practice: Cute Critters Collection

#### Setup

```
mkdir -p ~/workspace/python/exercises/petting_zoo && cd $_
touch animals.py
```

#### Instructions
1. Create 20 custom types (classes) for representing critters from Bobby's petting zoo in Python. Define each with the following properties in the `__init__` method so that each instance can have its own specific values for those properties:

+ name
+ species
+ date_added


If you have properly defined your classes, you should be able to do something like the following example:

```py
# Make an instance of the Goat class.
fainting_goat = Goat()
# Assign values to your object's properties
fainting_goat.name = "Bubba" 
fainting_goat.species = "fainting goat"
fainting_goat.date_added = "06/20/2020"
```

Use the `print()` method to see the results, like `print(goat)`.  
It will be...disappointing. you should see something like this: 

`<__main__.Goat object at 0x109df9cd0>`  

What the heck is that? Your instructors will explain this in more detail, and will eventually show you a trick for getting a mre human readable output. For now, just note that you can't log out a Python object the way you could a Javascript object, and try `print(fainting_goat.name)` as a temporary solution.


## Class Construction Arguments

The `__init__()` method on a Python class can accept as many arguments as you like. Those arguments can then be used to initialize the properties of each object created from the class. Here's an example.

```py
class Farm:

    def __init__(self, name, acres):
        self.business_name = name
        self.total_acreage = acres


rolling_hills = Farm("Rolling Hills Farm", 325)
```

By passing the property value in during the instantiation of the object, I don't have to manually create the properties on a separate line of code.

```py
# No need to do this!!
rolling_hills.business_name = "Rolling Hills Farm"
rolling_hills.total_acreage = 325
```

### Practice: Update Yer Critters Construction

Refactor your critter classes to make your `__init__` method accept three arguments

1. `name`
2. `species`
2. `date_added`

Once defined this way, you can send those values as parameters when you create each instance
