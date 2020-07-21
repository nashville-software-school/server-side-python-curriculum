# Critters and Croquettes: Day 8

>You bolt awake, covered in a cold sweat. As you sigh in relief that it was all just a dream, you realize something almost as scary: it could really happen! Just yesterday you were testing your code and you put an alligator in the petting zoo without a second thought. But alligators belong in Critter Cove, not Varmint Village. Right now, there's no limit to the type of animals that get placed in an attraction. 
>
>In Python, lists can contain any combination of object types. A single list could contain an integer, a boolean, and a string. This means that the `animals` attribute of your attractions classes can contain **any** critter type, regardless of whether it belongs there.
>
>You decide that you'll need to add a check to the `add_animal` method of your attractions classes to make sure a critter belongs in the attraction you're adding it to. Luckily, you already have a built-in way of determining what kind of critter you're dealing with...

### Using Your Inherited Class Properties to Restrict Lists

You are going to see two ways to make sure that only walking animals can be added to a petting zoo. One is by doing type checking, which is done in statically typed languages like Java or C#, and the other is the Pythonic way.

> #### `attractions/petting_zoo.py`

```py
from . import Attraction
from movements import Walking

class PettingZoo(Attraction):

    def __init__(self, name, description):
        super().__init__(name, description)
    
    # Number 1: Duck typing check
    def add_animal_pythonic(self, animal):
        try:
            if animal.walk_speed > -1:
                self.animals.append(animal)
                print(f"{animal} now lives in {self.attraction_name}")
        except AttributeError as ex:
            print(f'{animal} doesn\'t like to be petted, so please do not put it in the {self.name} attraction.')

    # Number 2: Actual typing check
    def add_animal_type_check(self, animal):
        if isinstance(animal, Walking):
            self.animals.append(animal)
            print(f"{animal} now lives in {self.attraction_name}")
        else:
            print(f'{animal} doesn\'t like to be petted, so please do not try to put it in the {self.name} attraction.')
```

Both methods stop an alligator from being added to a petting_zoo. One is more _Pythonic_ than the other, but both are effective. Our recommendation is to follow the guidance of the Python community and use _duck typing_, and exceptions to determine if an object can be used for any specific purpose.

> ### Duck Typing
>
> "If it looks like a duck, sounds like a duck, acts like a duck, and smells like a duck, then it can do all the things we want a duck to do. It's a duck."
>
> The idea is that it doesn't actually matter what type my data is - just whether or not I can do what I want with it.

Next, refactor your main logic to create a walking animal, like a llama, as well as a swimming animal, like an alligator

> #### `index.py`

```py
from animals import Llama
from animals import Alligator
from attractions import PettingZoo

varmint_village = PettingZoo("The Varmint Village", "critters that love to be pet!")

# remember, some animals may require more arguments than others; e.g. shift
dolly = Llama("Dolly", "miniature llama", "morning", "hay", 1033)
snappy = Alligator("Snappy", "American Alligator", "fish", 1044)

varmint_village.add_animal_pythonic(dolly)
varmint_village.add_animal_type_check(dolly)
varmint_village.add_animal_pythonic(snappy)
```

After you try adding the animals you should see the following output:

```
Dolly the miniature llama now lives in The Varmint Village
Dolly the miniature llama now lives in The Varmint Village
Snappy the alligator doesn't like to be petted, so please do not put it in the The Varmint Village attraction.
```

Now you can check to see which animal(s) were added to that attraction's animal list

```
for animal in varmint_village.animals:
    print(animal)
```

You will see that only the llama was added to the petting zoo (twice in this case).

```
Dolly the miniature llama
Dolly the miniature llama
```

## Practice: Birds of a Feather, Snakes of a Scale?
Refactor all of your attraction classes to check for the proper property before allowing the critter object to be added to its `animal` list.
