# Critters and Croquettes: Day 3

The next morning you flip open your laptop, ready to look over your code and figure out why it didn't seem right yesterday. But, before you can settle in to read over your work, an email comes in from Bobby Kawlins. The subject reads "Critter Culinary Chaos!!" You're not surprised that Bobby types like he talks: lots of exclamation points.

> "Hey there, awesome developer person! After we talked about tracking my animals' petting schedules, I had another idea." ('Why am I not surprised?', you say to yourself.) "With the place starting to really take off, I've hired a couple of interns to handle a lot of the care and feeding of all the critters. Frees me up to try out some new patatas bravas recipes for the tapas bar! 
>
>"Problem is, we're having trouble keeping straight who fed what to which animal and when. Sound like something you can handle?"
>
>A quick reply of "No worries. I'll add the ability to feed a critter" and you get to work.

## Adding methods to the madness
Luckily for you, and for Bobby, objects can not only represent attributes of something from the real world, they can represent behaviors too. A critter can also _do stuff_, and we can interact with that critter. 

In our code, defining how to do stuff means using our old friend the function. And you know from your JavaScript days that when an object contains a function as a property, it's called a _method_.

Let's add the ability to feed a critter in Bobby's petting zoo their particular food. We'll use the Llama example from the earlier chapter.

```py
from datetime import date

class Llama:

    def __init__(self, name, species, shift, food):
        self.name = name
        self.species = species
        self.date_added = date.today()
        self.walking = True
        self.food = food

    def feed(self):
      print(f'{self.name} was fed {self.food} on {date.today().strftime("%m/%d/%Y")}')
```

Remember the `self` parameter you have to add to __init__ when you define it? The same rule applies to all methods in a Python class

```py
miss_fuzz = Llama("Miss Fuzz", "domestic llama", "morning", "Llama Chow" )

print(miss_fuzz.feed())
```
When you run that code, it produces this output (your date will vary)

```
Miss Fuzz was fed Llama Chow on 06/29/2020
``` 
## Practice: Feed your Critters
Refactor your critter classes to add a `food` property and a `feed` method

## Practice: Convert Critter Objects to a String

In the first Classes chapter, we mentioned that printing an instance give you a not-so-helpful-looking representation of that object. One way to get a more human-readable result is to define a string representation of your instance with __str__ and __repr__. 

Use the [`__str__` and `__repr__`](https://realpython.com/lessons/how-and-when-use-__str__/) magic methods on your classes to specify what an object's string representation should be. It's just like the `toString()` method in JavaScript.
The difference between the two methods is trivial at this point. Feel free to stick with `__str__`.

Currently, if you print a `Chicken` object, for example, the output would look something like below.

```py
foghorn_leghorn = Chicken("Foghorn Leghorn", "leghorn rooster", "cracked corn")

print(foghorn_leghorn)
```
Terminal output:  
`<__main__.Chicken object at 0x107133f60>`

But if you specify exactly what string should be returned from `__str__` or `__repr__`, that will print out instead. If you implement the following method on your class...

```py
class Chicken:
    ...

    def __str__(self):
        return f"{self.name} is a {self.species}"
```

...then the output will change.

```py
print(foghorn_leghorn)
```
Terminal output:  
`Foghorn Leghorn is a leghorn rooster`

Change your critter classes so that any objects created from them will be rerpesented as strings in the above format.
