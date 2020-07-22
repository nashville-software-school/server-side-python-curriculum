# Critters and Croquettes: Day 6

> You are heads-down, working on your code when a co-worker Slacks you a link to an article in the Gatlinburg Visitor Gazette. It's a story about local attractions and their colorful owners. At the top is a picture of Bobby, smiling widely as always, pointing to a couple of frolicking goats. He's holding a cheerful-looking child who seems as enthralled by the critters as he is. The caption grabs your attention.
>
> _"Critters and Croquettes Petting Zoo and Tapas Bar owner Bobby Andrew Kawlins surveys his ever-growing appetizers and animals empire with daughter Bobbi-Jean. 'One day, this will all be yours,' says the effervescent entrepreneur. 'You'll inherit what I built and make it bigger and better than ever!"_
>
>You chuckle thinking about whether that's a blessing or a curse for little Bobbi-Jean. Then your eyes fall back to a particular word in the caption: "inherit". Something clicks in your mind and you swivel back to your code.
>
>Inheritance! That's it! That weird feeling you've had in the pit of your stomach that something wasn't quite right with your approach to all those critter classes. It wasn't just you breathing in the smell of too many farm animals. 
>
>All the repetition in your code; the sense that it wasn't DRY enough; the pain of constant refactoring -- it could all be lessened greatly by using inheritance, a mechanism in Object Oriented Programming that's perfect for just this kind of situation. 
>
>You think back to your time at NSS and the incredibly wise, insightful words of your brilliant -- yet humble -- instructors...

## Class Based Inheritance

Class based inheritance lets you specify that one type will contain **all** of the properties and methods that are defined in _another_ type, without having to duplicate the code in the two source code files. Inheritance is a powerful feature of Python, but it should be used sparingly when you are defining many types in your program.

### Why Are You Learning This?

You will use inheritance to reduce the amount of duplicated code that can arise in a system with dozens of types that all share the **exact** same properties and/or methods. It's one of the mechanisms to introduce polymorphism into a program. 

_( Admit it, you were about to just keep on reading without asking what polymorphism is, weren't you? Go ahead. Look it up. We'll wait. This [article](https://www.programiz.com/python-programming/polymorphism) is especially easy to read. Later in the chapter you'll see a small example of it in action )_

You will likely be asked about inheritance during the interview process and should be able to describe it in one of the following ways.

1. Allows one type to include all of the public properties and methods of another type.
1. It reduces duplicated code when many types in a program all have the same properties and methods.

### Finding Common Ground

When considering inheritance, you examine your code to look for properties and methods that **all** of the classes have in common.

Are there any in the classes below?

```py
# Electric motorcycle
class Zero:
    def __init__(self):
        self.battery_kwh = 0
        self.main_color = 0
        self.maximum_occupancy = 0

    def charge_battery(self):
        ...
```

```py
# Propellor light aircraft
class Cessna:
    def __init__(self):
        self.fuel_capacity = 0
        self.main_color = 0
        self.maximum_occupancy = 0

    def refuel_tank(self):
        ...
```

```py
# Electric car
class Tesla:
    def __init__(self):
        self.battery_kwh = 0
        self.main_color = 0
        self.maximum_occupancy = 0

    def charge_battery(self):
        ...
```

```py
# Gas powered truck
class Ram:
    def __init__(self):
        self.fuel_capacity = 0
        self.main_color = 0
        self.maximum_occupancy = 0

    def refuel_tank(self):
        ...
```

That's right. They all share `main_color` and `maximum_occupancy`.

As you add more vehicle types to your system, it would get very tedious to keep defining those properties in each of those classes. It would also increase the possibililty of bugs being introduced. If your team decided to rename the `main_color` property to `base_color`, all of the classes would need to be changed. Since human beings are highly prone to error, a class could be missed during refactoring.

To avoid these kinds of problems, you can to create a more general type in your system and then have all vehicles inherit from it.

## Vehicle Class

Since all of the types are vehicles, a good name for this new type would be `Vehicle`. It contains the properties that were determined to be common to all vehicles in this system. **`Vehicle`** is now the base, or parent, class.

```py
class Vehicle:
    def __init__(self):
        self.main_color = ""
        self.maximum_occupancy = ""
```

Then each of the other, more specific, types would inherit from it. The syntax for inheritance is dead simple: Simply specify the parent class in parenthesis after the class definition.

```py
class Tesla(Vehicle):
    def __init__(self):
        self.battery_kwh = 0

    def charge_battery(self):
        ...
```

Now any instance of **`Tesla`** will have both of the properties from **`Vehicle`** on it automatically. **`Tesla`** is now a derived, or child, class because it inherits the properties of **`Vehicle`**.

```py
model_3 = Tesla()
model_3.main_color = "red"

print(model_3.main_color)
#prints red
```

## Lean and Mean Critters

>It's amazing how all that info just came flooding back to you. Dang, those NSS instructors were so great. You really should send them a note sometime to let them know how you're doing. Or buy them lunch at a pricey but tasteful local restaurant. For now, though, it's time to kick some critter code into high gear.
>
>All those critter types with identical properties -- that's the first thing to tackle. You decide to consolidate them into a base class. They're all animals, so it makes sense to name it **`Animal`**

```py
class Animal:
    def __init__(self, name, species, food, chip_num):
        self.name = name
        self.species = species
        self.food = food
        self.__chip_number = chip_num
        self.date_added = date.today()

    def feed(self):
        print(f'{self.name} was fed {self.food} on {date.today().strftime("%m/%d/%Y")}')
    
    @property
    def chip_number(self):
        return self.__chip_number
    
    @chip_number.setter
    def chip_number(self, num):
        pass
```
>With all of the properties that were common across all critter types defined in one class, you turn your attention to the existing pile of class definitions. They will need some additions and subtractions to make them all child classes of **`Animal`**. You start with **`Llama`**

**Before:**
```py
class Llama:

    def __init__(self, name, species, shift, food, chip_num):
        self.name = name
        self.species = species
        self.shift = shift
        self.date_added = date.today()
        self.food = food
        self.__chip_number = chip_num
        self.walking = True
    
    def feed(self):
        print(f'{self.name} was fed {self.food} on {date.today().strftime("%m/%d/%Y")}')
  
    ...
```
**After:**
```py
# Designate Llama as a child class by adding (Animal) after the class name
class Llama(Animal):

    # Remove redundant properties from Llama's initialization, and set their values via Animal
    def __init__(self, name, species, shift, food, chip_num):
        super().__init__(name, species, food, chip_num)
        self.shift = shift # stays on Llama because not all animals have shifts
        self.walking = True
```
Luckily, the syntax for making a llama object stays exactly the same: 

```py
stinky = Llama("Stinky", "domestic llama", "afternoon", "barley hay")
```

Some things to note about these changes:
1. The `walking` atribute was not added to **`Animal`**, but instead stays on **`Llama`**. Why? It's not unique to Llama, right? True, but because it's not a property shared by all critters in our system, it doesn't belong on **`Animal`**

2. We can still pass the values for a llama object to **`Llama`**, even though those properties are now defined in **`Animal`**. How? Inside **`Llama`**'s `__init__` function we call **`Animal`**'s `__init__` function and pass those values "up" to it. `super()` is Python's way of designating the parent class. Here, `super` is used in the sense of meaning 'above' or 'of the highest power'.

3. Notice that we did not directly use **`Animal`** to make our llama object. At no point will you ever directly instantiate a base class. Instances are always created from the child class.

### Practice: The Great Inheritance Overhaul
You know the drill by now! It's time to refactor all of your classes. This time it's in the name of not having to spend so much time refactoring your classes in the future. 
1. Start by defining **`Animal`** at the top of `animals.py`. 
1. Work your way through your critters to evolve them into its children.

## Overriding Parent Behavior

Earlier in this chapter you may remember a mention of polymorphism. In a very small nutshell polymorphism means the ability to take various forms. Sounds like Invasion of the Body Snatchers, but this example shows how that can be expressed in Python.  

You've now seen how to inherit common properties from a parent class. Each child class of **`Animal`**, for example can call `feed()` because they automatically inherit it. This is great for when the act of feeding a critter is exactly the same for every critter type. But it's not ideal if you have an outlier or two that require a different behavior for the same action of 'feeding'. 

Let's use our **`Llama`** class again. Let's say that Bobby's llamas are a bit skittish and won't eat unless they feel calm and safe. Bobby has found that singing "Rockytop" to them somehow calms them down, and they then gobble all their Llama Chow. Feeding a llama, then, requires an extra step.

So, if feeding a llama is an action unique to a llama, you might decide that the key is to define a method directly on **`Llama`** to describe the action of feeding a llama. And you'd be right!

And that function's behavior could be 
```py
print(f'on {date.today()}, {self.name} had "Rockytop" sung to it so it would eat its {self.food}')
```
That way only llamas get fed while singing to them. The question is, what do you name that function? `feed_llama`? Nope. Actually, you would name it `feed`. By giving it exactly the same name as **`Animal`**'s method for feeding _all_ animals, you then **_override_** the default logic.  

[Method overriding](https://en.wikipedia.org/wiki/Method_overriding), in object-oriented programming, is a language feature that allows a subclass or child class to provide a specific implementation of a method that is already provided by one of its superclasses (parent classes). 

Now, `feed` has multiple forms, but is implemented differently in different contexts using method overriding. That's polymorphism, and it's really cool and powerful. (Got your attention now? Here's that [article](https://www.programiz.com/python-programming/polymorphism) again.)

Let's look at another example, using the vehicles from earlier. You can safely assume that each vehicle can be driven. What you can then do is implement a `drive()` method on the **`Vehicle`** class.


```py
class Vehicle:
    def __init__(self):
        self.main_color = ""
        self.maximum_occupancy = ""

    def drive(self):
        print("Vroooom!")
```

Once you do this, all of the specific vehicles can be driven. For now, however, they will all make the same sound, which is ridiculous because a plane doesn't sound like a truck which doesn't sound like a motorcycle.

```cs
fxs = Zero()
modelS = Tesla()
mx410 = Cessna()

fxs.drive()
modelS.drive()
mx410.drive()
```

To have each vehicle make its own sound, all you need to do is define that method in the child.

```py
class Tesla(Vehicle):
    def __init__(self):
        self.battery_kwh = 0

    def drive(self):
        print("Zoooooooooooom!")
```

Now the Tesla will make a different noise.

Also read [Method Overriding in Python](https://www.studytonight.com/python/method-overriding-in-python).

### Practice: Pacify Your Picky Eaters
Customize the way some of your critters are fed. Use method overriding to define a more specific `feed` behavior on three of your child classes. 

If you're feeling experimental, see what happens when you don't name your method feed. Call it `feed_llama` for example. What happens when you call it? Can you still call `feed`, too? What happens? Can you think why that might be problematic? Discuss that with your classmates, or ping an instructor with your thoughts.
