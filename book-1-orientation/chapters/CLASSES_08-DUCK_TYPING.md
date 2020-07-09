# Critters and Croquettes: Day 8

>You bolt awake, covered in a cold sweat. As you sigh in relief that it was all just a dream, you realize something almost as scary: it could really happen! Just yesterday you were testing your code and you put a goose in the petting zoo without a second thought. But geese belong in Critter Cove, not Varmint Village. Right now, there's no way to limit the type of animals that get placed in an attraction. 
>
>In Python, lists can contain any combination of object types. A single list could contain an integer, a boolean, and a string. This means that the `animals` attribute of your attractions classes can contain **any** kind of animal, regardless of whether it belongs there.
>
>You decide that you'll need to add a check to the `addAnimal` method of your attractions classes to make sure a critter belongs in the attraction you're adding it to. Luckily, you already have a built-in way of determining what kind of critter you're dealing with...

### Using Your Inherited Class Properties to Restrict Lists

You are going to see two ways to make sure that only walking animals can be added to a petting zoo. One is by doing type checking, which is done in statically typed languages like Java or C#, and the other is the Pythonic way.

> #### `attractions/petting_zoo.py`

```py
from . import Attraction
from movements import Swimming

class PettingZoo(Attraction):

    def __init__(self, name, description):
        super().__init__(name, description)
    
    # Number 1: Duck typing check
    def add_animal_pythonic(self, animal):
        try:
            if animal.swim_speed > -1:
                self.animals.append(animal)
        except AttributeError as ex:
            print(f'{animal} doesn\'t like to be petted, so please do not try to put it in the {self.name} attraction')

    # Number 2: Actual typing check
    def add_animal_type_check(self, animal):
        if isinstance(animal, Swimming):
            self.animals.add(animal)
        else:
            print(f'{animal} doesn\'t like to be petted, so please do not try to put it in the {self.name} attraction')
```

> ### Sidebar: Duck Typing
>
> "If it looks like a duck, sounds like a duck, acts like a duck, and smells like a duck, then it can do all the things we want a duck to do. It's a duck."
>
> The idea is that it doesn't actually matter what type my data is - just whether or not I can do what I want with it.

Next, refactor your main logic to create a walking animal, like a llama.

> #### `index.py`

```py
from animals import Goose, Llama
from attractions import PettingZoo


bob = Goose("Bob")
miss_fuzz = Llama("Miss Fuzz")

varmint_village = PettingZoo("The Varmint Village")
varmint_village.add_animal_pythonic(bob)
varmint_village.add_animal_type_check(bob)
varmint_village.add_animal_pythonic(miss_fuzz)

for animal in varmint_village.animals:
    print(f'{animal} lives in Varmint Village')
```

Now the output is different. You will see that only the llama was added to the petting zoo.

```
Bob the goose doesn't like to be petted, so please do not try to put it in The Varmint Village attraction
Bob the goose doesn't like to be petted, so please do not try to put it in The Varmint Village attraction
Miss Fuzz the llama lives in The Varmint Village
```

Both methods stopped a goose from being added to a petting_zoo. One is more _Pythonic_ than the other, but both are effective. Our recommendation is to follow the guidance of the Python community and use duck typing, and exceptions to determine if an object can be used for any specific purpose.

## Practice: Birds of a Feather, Snakes of a Scale?
Refactor all of your attraction classes to check for the proper property before allowing the critter object to be added to its `animal` list.
