# Interface Based Programming

In Python, you can use classes to represent concrete things - Person, Building, Vehicle, Animal, Flower - but you also use them to define general types of things so that they can be grouped together in a more flexible way. The mechanism in Python is multiple inheritance. You can inherit from **more** than just one parent class!

## Why Are You Learning This?

You will use multiple inheritance to provide much more flexibility to your project to work with disparate types. It's one of the most powerful features of the Python language.

You will also likely be asked about interfaces during the interview process. Python does not have concrete interfaces, but you can use classes to implement an interface-based system. After working with interfaces during your time at Nashville Software School, you should be able to describe interfaces in the following ways.

1. Interfaces are a mechanism to introduce polymorphism into your system. They provide additional types to your classes.
1. They allow you to define common properties and behaviors among different classes in your system so that you can group them together into collections.

## Zoological Zaniness

Imagine a scenario in which you are writing an application in which you need to classify any animal species as ground-based, air-based, or water-based. Also consider that animals can be any combination of those classifications.

For example, a platypus is both ground and water. Most birds are both air and ground. Cats are ground only. Dolphins are water only. Seagulls are air, ground, and water (they can dive to amazing depths and are great swimmers). So many possible combinations of behavior in the animal kingdom!

🐯 🦅 🐎 🦈 🙎🏾‍♀️ 🦉

To make our code base as flexible as possible, we define the properties and behaviors of each classification (or description) into an separate class. You are going to start with classes for animals that can walk and those that can swim.

> movements.py

```py
class Walking:

    def __init__(self):
        self.walk_speed = 0
        self.legs = 0

    def run(self):
        print("The animal walks")

class Swimming:

    def __init__(self):
        self.swim_speed = 0
        self.maximum_depth = 0

    def swim(self):
        print("The animal swims")
```


Now you can define a class an implement the interface for a walking animal. You can start with a Penguin.

> animals.py

```py
from movements import Walking, Swimming


class Penguin(Walking, Swimming):
    def __init__(self, name):
        self.name = name

if __name__ == "__main__":

    bob = Penguin("Bob")
    bob.run()
    bob.swim()
```

##### Output

```sh
The animal walks
The animal swims
```

The `Penguin` class is now composed of the methods and properties of two smaller, focused classes.

### Overriding the Run Method

The run method's output is pretty boring and generic. I would rather state that a penguin waddles instead of walks.

```py
class Penguin(Walking, Swimming):
    def __init__(self, name):
        self.name = name

    def run(self):
        print(f"{self.name} the Penguins waddles")
```

##### Output

```sh
Bob the Penguin waddles
The animal swims
```

Now each class can override and specialize inherited behavior, or simply choose to let the parent class' logic run, depending on the situation.

## Habitats for Certain Types of Animals

Time to start putting animals in habitats. You need to create classes to hold certain kinds of animals. For example, the Aquarium habitat will hold swimming animals, and the Savannah habitat will hold walking animals.

Define a Habitat class in a new module.

> habitats.py

```py
class Habitat:

    def __init__(self):
        self.name = ""
        self.animals = set()

    def add_animal(self, animal):
        self.animals.add(animal)

    def remove_animal(self, animal):
        self.animals.remove(animal)
```

Next, import that module into animals, create a new habitat, and add Bob to it.

> animals.py

```py
from movement import Walking, Swimming, Flying
from habitat import Habitat


class Penguin(Walking, Swimming):
    def __init__(self, name):
        self.name = name

    def run(self):
        print(f"{self.name} the Penguin waddles")


if __name__ == "__main__":

    # Create a penguin
    bob = Penguin("Bob")

    # Create a habitat
    SeaWorld = Habitat()
    SeaWorld.add_animal(bob)

    print(SeaWorld.animals)
```

When the set of animals is printed, you will see the following output.

```sh
{<__main__.Penguin object at 0x105efe3c8>}
```

You now have one penguin in the habitat.

Next, create a class for an African Painted Dog beneath the penguin class. Dogs can only walk. They can't fly and are awful in the water.

```py
class PaintedDog(Walking):
    def __init__(self, name):
        self.name = name
```

Next, create a new painted dog instance and add it to the habitat.

```py
if __name__ == "__main__":

    bob = Penguin("Bob")
    ralph = PaintedDog("Ralph")

    SeaWorld = Habitat()
    SeaWorld.add_animal(bob)
    SeaWorld.add_animal(ralph)

    print(SeaWorld.animals)
```

Now you see that there are two animals in the habitat.

```sh
{<__main__.PaintedDog object at 0x102a344e0>, <__main__.Penguin object at 0x102a34470>}
```

But you named the habitat SeaWorld, which makes the assumption that **only swimming animals** should go into it. Right now, there's no way to limit the type of animals that gets placed in SeaWorld. What you need to do at this point is create a child class of Habitat called Aquarium, and in that class we can make sure that only swimming animals can be placed in it. Time to refactor `habitat.py`.

You will use the [Python isinstance()](https://www.w3schools.com/python/ref_func_isinstance.asp) method to determine if an object inherited from a specific parent class.

> habitat.py

```py
from movement import Swimming


class Habitat:

    def __init__(self):
        self.name = ""
        self.animals = set()

    def add_animal(self, animal):
        self.animals.add(animal)

    def remove_animal(self, animal):
        self.animals.remove(animal)


class Aquarium(Habitat):

    def __init__(self):
        super().__init__()

    def add_animal(self, animal):
        # Add animal only if it inherited from
        # the Swimming interface class
        if isinstance(animal, Swimming):
            self.animals.add(animal)
```

Next, refactor your main logic to create an aquarium.

```py
from habitat import Aquarium, Habitat


if __name__ == "__main__":

    bob = Penguin("Bob")
    ralph = PaintedDog("Ralph")

    SeaWorld = Aquarium()
    SeaWorld.add_animal(bob)
    SeaWorld.add_animal(ralph)

    print(SeaWorld.animals)
```

Now the output is different. You will only see the penguin.

```sh
{<__main__.Penguin object at 0x1007a1470>}
```

## Resources

* [Interface-based programming](https://en.wikipedia.org/wiki/Interface-based_programming)
* [Understanding Interface-based Programming](https://msdn.microsoft.com/en-us/library/aa260635(v=vs.60).aspx)

## Practice: Diggers and Fliers

As an avid animal lover, you have started your very own collection of creatures in your home. You can use the code from the lesson as a starting point to have interfaces for walking and swimming animals, but you want to have several other kinds in your collection.

This is the list of animals you want to own and care for.

1. Parakeets
1. Earthworms
1. [Terrapins](https://en.wikipedia.org/wiki/Terrapin)
1. Timber Rattlesnake
1. Mice
1. Ants
1. Finches
1. [Betta Fish](https://bettafish.org/)
1. Copperhead snake
1. Gerbils

Each month, you clean out all of the habitats in a single day for efficiency. On that day, all animals need to be put into temporary containers. Each container will hold animals of similar, but different, types.

* Animals that dig and live in the ground
* Animals that move about on the ground
* Animals that swim in water
* Animals that fly above the ground

1. Before you write any classes for the above animals, determine the common properties and behaviors that some of them share and define interface classes first.
1. Once you believe you have a good set of interface classes, then start creating your specific animals and have them implement the appropriate interface(s).
1. Then define classes to represent the containers that will hold various animals. Each container class should have a single property - a set to hold animal instances.
1. Lastly, create one (or more if you like) instances of each type of animal and each container. Then add the animals to their corresponding container.
