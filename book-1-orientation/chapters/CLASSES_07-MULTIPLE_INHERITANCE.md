# Critters and Croquettes: Day 7

<!-- TODO: Critter Intro -->

# Multiple Inheritance

In Python, you can use classes to represent concrete things - Person, Building, Vehicle, Animal, Flower - but you also use them to define general types of things so that they can be grouped together in a more flexible way. That mechanism in Python is called multiple inheritance. You can inherit from **more** than just one parent class!

## Why Are You Learning This?

You will use multiple inheritance to provide much more flexibility to your project to work with disparate types. It's one of the most powerful features of the Python language.

## Zoological Zaniness

Think about those ducks at the petting zoo. You classified them as `swimming` critters, but they can also fly and walk. And if Bobby ever added penguins (you wouldn't put it past him) they swim and walk, but they don't fly. Basically, a single property to define how a critter moves around is limiting. There are many possible combinations of behavior in the animal kingdom!

🐯 🦅 🐎 🦈 🙎🏾‍♀️ 🦉

Additionaly, you also can see how, for example, `swimming` is present on some of your critter classes, but not all of them. 
Wouldn't it be nice to define `swimming` once and use it over and over just like you are doing with `name` and `species` in **`Animal`**? That kind of flexibility would make it infinitely easier to represent the widest variety of critters possible in our system. 

Multiple Inheritance to the rescue.

To make our code base as flexible as possible, you can define the properties and behaviors of each classification (or description) into a _separate class_. 

Note that these new classes will seem skimpy. They will seemingly do very little. This is by design. Their job will not be to directly represent a concrete thing, but to aid you in the process of representing a concrete thing. They will be used to compose behavior and properties **into** objects that represent real things. But, they are still just good old Python classes. And that's why it's called multiple inheritance. You can define a derived type that inherits properties from more than a single parent class.




![](./images/zoo-directory-structure.png)

## Defining How Animals Move

The first step is to define the different ways an animal can move.

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

**NOTE:** When a class inherits from two parents you have to discard using the `super().__init__()` syntax and explicitly invoke the initialization method of both. You also need to pass `self` as an argument - something that is not needed when you use the `super()` abstraction.

> #### `animals/goose.py`

```py
from movements import Walking, Swimming


class Goose(Animal, Walking, Swimming):

    def __init__(self, name, species, food):
        Animal.__init__(self, name, species, food)
        Swimming.__init__(self)
        Walking.__init__(self)
    
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

<!-- TODO: refactor from here to end-->
In your main zoo module, import the **`Penguin`** class, and create one. Then makes it walk and swim.

> #### `zoo.py`

```py
from animals import Penguin


bob = Penguin("Bob")
bob.run()
bob.swim()
```

This produces the following output.

```
The animal runs
The animal swims
```


### Overriding the Run Method

The run method's output is pretty boring and generic. I would rather state that a penguin waddles instead of walks. You can use method overriding to accomplish that.

> #### `animals/penguin.py`

```py
class Penguin(IWalking, ISwimming):

    def __init__(self, name):
        ISwimming.__init__(self)
        IWalking.__init__(self)
        self.name = name

    # run is defined in the Walking parent class, but also here. This run method will take precedence and Walking's run method will not be called by Goose instances
    def run(self):
        print(f'{self} waddles')

    def __str__(self):
        return f'{self.name} the Penguin'
```

##### Output

```sh
Bob the Penguin waddles
The animal swims
```

Now each class can override and specialize inherited behavior, or simply choose to let the parent class' logic run, depending on the situation.


## Habitats for Certain Types of Animals

Time to refactor how you are adding animals to attractions. You need to create classes to hold certain kinds of animals. For example, the Aquarium habitat will hold swimming animals, and the Savannah habitat will hold walking animals.

Define a Habitat class in a new module.

> #### `habitats/habitat.py`

```py
class Habitat:

    def __init__(self, name):
        self.name = name
        self.animals = set()

    def add_animal(self, animal):
        self.animals.add(animal)

    def remove_animal(self, animal):
        self.animals.remove(animal)

    def __str__(self):
        return f'{self.name} ({len(self)} animals)'

    def __len__(self):
        return len(self.animals)
```

Next, import that module into the zoo module, create a new habitat, and add Bob to it.

> #### `zoo.py`

```py
from animals import Penguin
from habitat import Habitat


# Create a penguin
bob = Penguin("Bob")

# Create a habitat
seaworld = Habitat("Sea World")
seaworld.add_animal(bob)

for animal in seaworld.animals:
    print(animal)
```

When the set of animals is printed, you will see the following output.

```sh
Bob the Penguin
```

You now have one penguin in the habitat.

### Unrestrictive Lists

In Python, lists can contain any combination of object types. A single list could contain an integer, a boolean, and a string. This means that the `animals` attribute of your Sea World habitat can contain **any** kind of animal, regardless if it that animal can swim.

Time to see this in action, and see why you should write code to avoid this from happening in nearly every case.

### Painted Dogs Can't Swim

Create a class for an African Painted Dog in a new file. Dogs can only walk. They can't fly and are awful in the water.

> #### `animals/painted_dog.py`

```py
from movements import IWalking


class PaintedDog(IWalking):

    def __init__(self, name):
        super().__init__()
        self.name = name

    def __str__(self):
        return f'{self.name} the Painted Dog'
```

Add the Painted Dog type to the `animals` namespace.

> #### `animals/__init__.py`

```py
from .penguin import Penguin
from .painted_dog import PaintedDog
```

Next, create a new painted dog instance in your main module, and add it to the habitat.

> #### `zoo.py`

```py
from animals import Penguin, PaintedDog
from habitat import Habitat


bob = Penguin("Bob")
ralph = PaintedDog("Ralph")

seaworld = Habitat("Sea World")
seaworld.add_animal(bob)
seaworld.add_animal(ralph)

for animal in seaworld.animals:
    print(animal)
```

Now you see that there are two animals in the habitat.

```sh
Ralph the Painted Dog
Bob the Penguin
```

But you named the habitat SeaWorld, which makes the assumption that **only swimming animals** should go into it. Right now, there's no way to limit the type of animals that gets placed in SeaWorld. What you need to do at this point is create a derived class of Habitat called Aquarium, and in that class we can make sure that only swimming animals can be placed in it.

### Using your Interfaces to Restrict Lists

You are going to see two ways to make sure that only swimming animals can be added to an aquarium habitat. One is by doing type checking, which is done in statically typed languages like Java or C#, and the other is the Pythonic way.

> #### `habitats/aquarium.py`

```py
from . import Habitat
from movements import ISwimming

class Aquarium(Habitat):

    def __init__(self, name):
        super().__init__(name)

    # Duck typing check
    def add_swimmer_pythonic(self, animal):
        try:
            if animal.swim_speed > -1:
                self.animals.add(animal)
        except AttributeError as ex:
            print(f'{animal} can\'t swim, so please do not try to put it in the {self.name} habitat')

    # Actual typing check
    def add_swimmer_type_check(self, animal):
        if isinstance(animal, ISwimming):
            self.animals.add(animal)
        else:
            print(f'{animal} can\'t swim, so please do not try to put it in the {self.name} habitat')
```

> ### Sidebar: Duck Typing
>
> "If it looks like a duck, sounds like a duck, acts like a duck, and smells like a duck, then it can do all the things we want a duck to do. It's a duck."
>
> The idea is that it doesn't actually matter what type my data is - just whether or not I can do what I want with it.

Add the new class to the `habitats` package.

> #### `habitats/__init__.py`

```py
from .habitat import Habitat
from .aquarium import Aquarium
```

Next, refactor your main logic to create an aquarium.

> #### `zoo.py`

```py
from animals import Penguin, PaintedDog
from habitats import Aquarium


bob = Penguin("Bob")
ralph = PaintedDog("Ralph")

seaworld = Aquarium("Sea World")
seaworld.add_swimmer_pythonic(bob)
seaworld.add_swimmer_pythonic(ralph)
seaworld.add_swimmer_type_check(ralph)

for animal in seaworld.animals:
    print(f'{animal} lives in Sea World')
```

Now the output is different. You will see that only the penguin was added to the habitat.

```
Ralph the Painted Dog can't swim, so please do not try to put it in the Sea World habitat
Ralph the Painted Dog can't swim, so please do not try to put it in the Sea World habitat
Bob the Penguin lives in Sea World
```

Both methods stopped a painted dog from being added to an aquarium. One is more _Pythonic_ than the other, but both are effective. Our recommendation is to follow the guidance of the Python community and use duck typing, and exceptions to determine if an object can be used for any specific purpose.

## Practice: Modularize ALL. THE. THINGS.

Now that you have all the moving parts of your newly-flexible code working with multiple inheritance, it's time to do some house cleaning to organize and modularize. You should end up with the following file structure. Move the appropriate code into their files where necessary.

You will also need to create an `__init__.py` file at the root of each subdirectory, as shown. The `__init__.py` file makes the directories into packages. Refer back to the [packages](https://github.com/nashville-software-school/bangazon-llc/blob/master/book-1-orientation/chapters/PYTHON_PACKAGES.md) chapter for guidance on this if you need to.

```sh
petting_zoo/
    |__ animals/
          |__ __init__.py
          |__ animal.py # put Animal class in here
          |__ llama.py # one critter class
          |__ goat.py # another critter class. you get the point 
    |__ attractions/
          |__ __init__.py
          |__ atttraction.py
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

Finally, test everything to make sure your imports are working as they should. Wow, this is looking good! 
