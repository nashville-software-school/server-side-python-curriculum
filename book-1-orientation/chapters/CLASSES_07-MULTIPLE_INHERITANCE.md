# Critters and Croquettes: Day 7

# Multiple Inheritance

In Python, you can use classes to represent concrete things - Person, Building, Vehicle, Product, Flower - but you also use them to define general types of things so that they can be grouped together in a more flexible way. That mechanism in Python is called multiple inheritance. You can inherit from **more** than just one parent class!

## Why Are You Learning This?

You will use multiple inheritance to provide much more flexibility to your project to work with disparate types. It's one of the most powerful features of the Python language.

## Zoological Zaniness

Think about those ducks at the petting zoo. You classified them as `swimming` critters, but they can also fly and walk. And if Bobby ever added penguins (you wouldn't put it past him) they swim and walk, but they don't fly. Basically, a single property to define how a critter moves around is limiting. There are many possible combinations of behavior in the animal kingdom!

🐯 🦅 🐎 🦈 🙎🏾‍♀️ 🦉

Additionaly, you also can see how, for example, `swimming` is present on some of your critter classes, but not all of them.  

Wouldn't it be nice to define `swimming` once and use it over and over just like you are doing with `name` and `species` in **`Animal`**? That kind of flexibility would make it infinitely easier to represent the widest variety of critters possible in our system. 

Multiple Inheritance to the rescue!

To make our code base as flexible as possible, you can define the properties and behaviors of each classification (or description) into a separate class. 

Note that these new classes will seem skimpy. They will seemingly do very little. This is by design. Their job will not be to directly represent a concrete thing, but to aid you in the process of representing a concrete thing. They will be used to compose behavior and properties **into** objects that represent real things. But, they are still just good old Python classes. 

That's why it's called multiple inheritance. You can define a derived type that inherits properties from more than a single parent class.

## Practice: Modularize ALL. THE. THINGS.

Before you get all the moving parts of your newly-flexible code working with multiple inheritance, it's time to do some house cleaning to organize and modularize. You should end up with the following file structure. Create the necessary new directories and files and move the appropriate code into those files where necessary.

```sh
petting_zoo/
    |__ animals/
          |__ __init__.py
          |__ animal.py # put Animal class in here
          |__ llama.py # one critter class
          |__ goose.py # another critter class. you get the point 
    |__ attractions/
          |__ __init__.py
          |__ attraction.py
          |__ petting_zoo.py
          |__ snake_pit.py
          |__ wetlands.py
    |__ movements/
          |__ __init__.py
          |__ swimming.py
          |__ slithering.py
          |__ walking.py
    |__ index.py
```

As you can see, you will also need to create an `__init__.py` file at the root of each subdirectory. The `__init__.py` file makes the directories into packages. Refer back to the [packages](https://github.com/nashville-software-school/bangazon-llc/blob/master/book-1-orientation/chapters/PYTHON_PACKAGES.md) chapter for guidance on this if you need to.

## Defining How Animals Move

Now you're ready to roll. The first step is to take the properties you added to your critters that describe how they move, and define classes for those attributes instead.

> #### `movements/walking.py`

```py
class Walking:

    def __init__(self):
        self.walk_speed = 0
        self.legs = 0

    def run(self):
        print("The animal walks")
```

> #### `movements/swimming.py`

```py
class Swimming:

    def __init__(self):
        self.swim_speed = 0
        self.maximum_depth = 0

    def swim(self):
        print("The animal swims")
```

> #### `movements/slithering.py`
```py
class Slithering:

    def __init__(self):
        self.slither_speed = 0
        self.length = 0

    def slither(self):
        print("The animal slithers")
```

### Update the movements Package

> #### `movements/__init__.py`

```py
from .walking import Walking
from .swimming import Swimming
from .slithering import Slithering
```

Now you can define a class and implement multiple inheritance for a walking and swimming animal like a goose.

**NOTE:** When a class inherits from two parents you have to discard using the `super().__init__()` syntax and explicitly invoke the initialization method of both by name. You also need to pass `self` as an argument - something that is not needed when you use the `super()` abstraction.

> #### `animals/goose.py`

```py
# The package syntax is what allows for these clean import statements
from .animal import Animal
from movements import Walking, Swimming

class Goose(Animal, Walking, Swimming):

    def __init__(self, name, species, food):
        # No more super() when initializing multiple base classes
        Animal.__init__(self, name, species, food)
        Swimming.__init__(self)
        Walking.__init__(self)
        # no more self.swimming = True
        ...
    
    def honk(self): 
        print("The goose honks. A lot")

    def __str__(self):
        return f'{self.name} the Goose'
```

The **`Goose`** class is now composed of the methods and properties of the general base class of **`Animal`**, plus two smaller, focused classes.

### Update the Package

> #### `animals/__init__.py`

```py
from .goose import Goose
```

### Create a Goose
In your main `index.py` module, import the **`Goose`** class, and create one. Then make it walk and swim.

> #### `index.py`

```py
from animals import Goose


bob = Goose("Bob", "Canada goose", "watercress sandwiches")
bob.run()
bob.swim()
```

This produces the following output.

```
The animal runs
The animal swims
```

### Overriding the Run Method

The run method's output is pretty boring and generic. Wouldn't you rather state that a goose waddles instead of walks? Sure you would. You know from implementing it in a previous chapter that you can use method overriding to accomplish that.

> #### `animals/goose.py`

```py
class Goose(Animal, Walking, Swimming):

    def __init__(self, name, species, food):
        Animal.__init__(self, name, species, food)
        Swimming.__init__(self)
        Walking.__init__(self)
    
    def honk(self): 
        print("The goose honks. A lot")

    # run is defined in the Walking parent class, but also here. This run method will take precedence and Walking's run method will not be called by Goose instances
    def run(self):
        print(f'{self} waddles')

    def __str__(self):
        return f'{self.name} the Goose'
```

##### Output

```sh
Bob the Goose waddles
The animal swims
```

Now each class can override and specialize inherited behavior, or simply choose to let the parent class' logic run, depending on the situation.

## Practice: More Attractive Attractions 

Your critter types are in much better shape, so it's time to overhaul the attractions, too, and apply some inheritance magic to them. After all, what happens when Bobby announces he's adding a "Monkey Island" or "Big Kat Kountry"? 

Having an **`Attraction`** base class makes a lot of sense when you think about how quickly Bobby's business is growing.

Define an **`Attraction`** class in the new `attractions.py` module you created earlier. While we're at it, let's add some aditional behavior -- a delete method -- and define two dunder methods to help with identifying our objects -- `__str__` and `__len__`.

> #### `attractions/attraction.py`

```py
class Attraction:

    def __init__(self, name, description):
        self.attraction_name = name
        self.description = description
        self.animals = list()

    def add_animal(self, animal):
        self.animals.append(animal)

    def remove_animal(self, animal):
        self.animals.remove(animal)

    def __str__(self):
        return f'{self.name} ({len(self)} animals)'

    def __len__(self):
        return len(self.animals)
```

Next, refactor **`PettingZoo`**, **`SnakePit`**, and **`Wetlands`** to be children of **`Attraction`**. Move each to its own module.  

Note that `description` is now an additional parameter in **`Attraction`**'s `__init__`. Be sure each child class handles that appropriately in its `__init__`.

Refactor example
```py
from . import Attraction

class PettingZoo(Attraction):

    def __init__(self, name, description):
        super().__init__(name, description)
      
```
Don't forget to add the module imports to the attractions package.

>attractions/__init__.py

```py
from .attraction import Attraction
from .petting_zoo import PettingZoo
# etc
```

Next, import that module into the index.py module, create a new attraction, and add Bob to it.

> #### `index.py`

```py
from animals import Goose
from attractions import PettingZoo


# Create a Goose
bob = Goose("Bob", "Canada goose", "watercress sandwiches")

# Create an attraction
varmint_village = PettingZoo("Varmint Village", "critters that like to dig and scurry")
varmint_village.add_animal(bob)

for animal in varmint_village.animals:
    print(animal)
```

When the list of animals is printed, you will see the following output.

```sh
Bob the Goose
```
You now have one goose in the petting zoo. Continue testing the creation of attractions and animals, and adding animals to attractions. 


>That night, you go to bed tired but feeling good about your use of inhertance to better define how objects can be created in your system. You sleep deeply and soundly, until just before sunrise, that is. That's when a terrible dream creeps in and disturbs your slumber.
>
>In the nightmare you are not a hotshot web app developer -- you are the newest intern at Critters and Croquettes Petting Zoo and Tapas Bar. And you have been assigned every job on the premises. 
>
>One secord you're refilling the Critter Mix dispensers, the next you're scrubbing burned-on albondigas from a mountain of baking pans. Then suddenly you're faced with adding dozens of new animals to the habitats. Like a modern-day Noah, they keep coming and you keep having to find a place to put them all. And they're coming too fast. You can't keep up!
>
>In your panicked state you make a mistake, then another and another. The wetlands ends up with a dozen bewildered goats desperately paddling around in it! Children cry as the petting zoo is overtaken by a hissing, biting goose named Bob! The snake pit is in chaos from an all-out battle between a flock of herons and the resident water snakes!
>
>The shadow of Bobby Andrew Kawlins falls on you...

To be continued
