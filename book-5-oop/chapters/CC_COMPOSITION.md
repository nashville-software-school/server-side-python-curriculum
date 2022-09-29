# Critters and Croquettes: Day 4

>By now, you've become used to calls from the ever-excited Bobby Kawlins about his beloved business. So, when your phone rings with the now-familiar number flashing on the sreen, you're not surprised when another curve ball comes your way.
>
>"Hold on to your flip flops," Bobby warns you. "Today we break ground on a massive expansion! The snake tank and goldfish pond are yesterday's news. Taking their place will be a custom-built 10,000-gallon terrarium/aquarian habitat, The Slither Inn, which will house more snakes than an Indiana Jones movie, and Critter Cove, Gatlinburg's only one-acre walk-through wetlands and wet bar, full of feathered friends and fantastic fish! And the petting zoo we're rebranding as Varmint Village! Now my visitors can hang out with a wider variety of critters than ever before in three awesome animal attractions!"
>
>Of course, you know Bobby isn't just calling to share the news of his burgeoning business.
>
>"Sounds like you're going to need a way to track which animals go into which attraction."
>
>"Dang, you're on the ball, aren'tcha? That's right. I want to record where we display our critters, so we don't end up with an intern putting a rabbit in with the rattlesnakes!"
>
>You think maybe what Bobby really needs is a better intern screening process. But you keep that thought to yourself.

## Type Relationships

Up to this point, although you have made a whole pile of different classes, you haven't had to worry about how types can relate to each other. But if you think about your experience with objects and data from the front end, you know that data relationships are critical to building applications of any complexity.

Now that Critters and Croquettes is exapanding into multiple animal attractions, this is a great time to expand your use of the class syntax to represent different real-world entities that have a relationship with each other.  

Start with the original attraction, the petting zoo. A llama or a miniature horse will never end up in the wetlands or the snake pit. But the petting zoo has many different animals in it. This is a one-to-many relationship. 

In Python, you can establish this relationship by defining a list on the petting zoo object that will contain instances of critters. Consider the following code.

```py
class PettingZoo:

    def __init__(self, name):
        self.attraction_name = name
        self.description = "cute and fuzzy critters to cuddle"
        self.animals = list()
```

When you create a petting zoo, you specify the name of it on construction, and it gets initialized with an empty list of animals.

```py
varmint_village = PettingZoo("Varmint Village")
```

Now when you define a critter...

```py
class Burro:

    def __init__(self, name, species, shift, food):
        self.name = name
        self.species = species
        self.shift = shift
        self.date_added = date.today()
        self.walking = True
        self.food = food
    
    def feed(self):
        print(f'{self.name} was fed {self.food} on {date.today().strftime("%m/%d/%Y")}')
```

you can create an instance...

```py
stinky = Burro("Stinky", "burro", "afternoon", "barley hay")
```

and then add your critter to the attraction

```py
varmint_village.animals.append(stinky)
```

Now the objects have a relationship with each other. If you want to view all the animals from the petting zoo, just iterate the `animals` list.

```py
for animal in varmint_village.animals:
    print(f'You can find {animal.name} the {animal.species} in {varmint_village.attraction_name}')
```

### Practice: Adding Attraction Types
Define custom types for the three different animal attractions at Critters and Croquettes --  **`PettingZoo`**, **`SnakePit`**, and **`Wetlands`**

1. Give them each properties of `attraction_name`, `description` and `animals`
1. `attraction_name` and `description` should be set when a habitat is instantiated, so be sure to have your `__init__` method take a arguments for setting those values
1. Give `animals` an ititial value of an empty list
1. Define a method on each class for adding animals to its `animals` array. Note that we did not do that in the example above. so, don't just copy and paste `PettingZoo`
1. Once you have instances of your animals and attractions created, assign your critters to their appropriate attraction.

1. Output a report to the terminal that displays each attraction and its animals.

For example:

```
Slither Inn is is where you'll find stupendous snakes of all sizes, like
   * Bitey the cobra
   * Fango the copperhead
   * Gertie the garter snake

Varmint Village is where you'll find cute and fuzzy critters to cuddle, like
   * Swooney the fainting goat
   * Wilbur the pot-bellied pig
   * Linda the domesticated llama
```

### Practice: Modularize it
Your original `animals.py` file must be getting gigantic by now. If you haven't already, get started with modularizing your code. Add additional files called `attractions.py` and `index.py`. 

It's fairly obvious that your attractions classes should move to `attractions.py`. But what might you move into `index.py`? The single responsibility principle still applies here in Python land. If some modules contain type declarations ( your classes ), should those same modules be responsible for creating instance objects, too? 

Probably not. There's your hint. Go for it. And ask for help if we just melted your brain. You might run your refactored, modularized code by an instructor regardless.
