# Critters and Croquettes: Day 5

> It's another perfect Smoky Mountains day, with cool air and a warm sun. You decide to head over to Critters and Croquettes for a light lunch and to see the plans Bobby has in store for his big expansion. When you arrive you're surprised to see Bobby looking worried. The usual exuberance isn't present today.
>
>"Had a bit of a fright this morning, friend," Bobby explains. "One of our more...clever...alpacas found a way to climb up on a bench and jump the fence into the parking lot. Luckily, she smelled a fresh batch of huevos estrellados drifting out of the tapas bar and she wandered back in through the front door!
>
>You remind yourself not to complain the next time your job feels boring or repetitive.
>
>"Got me to thinking, though," he says. "And I've decided to microchip all my critters in case one ever escapes. Or, heaven forbid, a customer decides to smuggle a snake or two out in their backpack.
>
>"So, I'm glad you're here. I'd like to have a way to record the chip number for a critter. Whatta you say?"
>
>"I say we can do that," you...say. 
>
>A few thoughts come to mind as you visualize adding a `chip_number` property to your critter classes.  
>#1. You should make sure the value is always input as a number, not a string, just to be consistent and predictable.  
>#2. Once a chip is added to an animal, that number is permanent and won't need to change.  
>#3. You're really glad you're not the employee who has to figure out how to microchip a copperhead.

## re: thought #1 -- Enforcing Python Class Property Values

By default, if you set an attribute of an object instance in, say, the `__init__` method, those values can be changed without restriction.

```py
class Product():

    def __init__(self):
        self.price = 0
        self.title = ""
        self.description = ""

kite = Product()
kite.price = 14.99
kite.title = "A red kite"
kite.description = "Flies up to 150 meters in the air. Made of nylon."

# Since Python is a dynamically typed language, I can set
# the value of those variable to anything
kite.price = dict()  # No complaints here
kite.description = 1024  # Python don't care
```

Since Python is dynamically typed, simple attributes have no way of enforcing what value they accept. Fortunately, the language provides a way for you to check and enforce value restrictions - the `@property` decorator. 

>Wait, what the heck is a 'decorator' you say? For now, focus on the concept of what is happening here and how to implement it. In an upcoming chapter your instructor will dive into the why/what/how of deocorators.

```py
class Product:

    @property # The getter
    def price(self):
        try:
            return self.__price # Note there are 2 underscores here
        except AttributeError:
            return 0

    @price.setter # The setter
    def price(self, new_price):
        if type(new_price) is float:
            self.__price = new_price
        else:
            raise TypeError('Please provide a floating point value for the price')
```

Now you have set a type check on what the value of the `price` attribute can be. 

```py
prod = Product()
print(prod.price)
# prints 0

prod.price = 1
```
In your terminal you'll see
```
>>> TypeError: Please provide a floating point value for the price
```

Now set the value to a floating point decimal.

```py
prod.price = 1.0 # Everything works ok
```
Did you notice the added bonus of using @property? You simply access the property name with good old dot notation. 

```py
prod.price
``` 

It's like magic ✨

## "Private" Variables

The `self.__price` is considered a privately scoped attribute and should not be accessed. It is obfuscated by Python to not show up as an attribute. There is a method in Python named `dir()`. It returns a list of valid attributes of the object. Look at what the valid attributes are for the object referenced by `prod`.

```py
print(dir(prod))

['__class__', '__delattr__', '__dict__', '__dir__',
 '__doc__', '__eq__', '__format__', '__ge__',
 '__getattribute__', '__gt__', '__hash__', '__init__',
 '__init_subclass__', '__le__', '__lt__', '__module__',
 '__ne__', '__new__', '__reduce__', '__reduce_ex__',
 '__repr__', '__setattr__', '__sizeof__', '__str__',
 '__subclasshook__', '__weakref__', 'price']
 ```

 Note that `price` is in that list, but `__price` is not. Therefore, even though you, as the class designer, know that `__price` exists, you should not try to access it on an instance of the class.


## re: thought #2 -- Read-Only Variables
@property decorators can also be used to make a property essentially read-only. "Essentially" meaning there's no such thing as a truly unchangeable attribute, but as you saw above, the double underscore syntax helps hide a value from direct access via typical `foo.attr` syntax. 

Say a product, upon instantiation, can be given a serial number. This would typically never need to change, but would be something you would want to be able to output with a simple `foo.serial_num`. 

```py
class Product:

    def __init__(self, serial_num):
        self.__serial_num = serial_num # setting the privately scoped attribute on instantiation

    # BTW, when you see "..." in a code example, it just means "assume there's some other code here but we don't want to type it because it's irrelevant to the example"
    ...

    @property # The getter
    def serial_num(self):
        return self.__serial_num # now foo.serial_num will actually return the private value. There is no actual serial_num attribute. So sneaky of us.

    @serial_num.setter # The setter
    def serial_num(self, number):
        pass # here, we simply tell the function to do nothing, effectively preventing the setting of a value for .serial_num. Without the setter, though, an attempt to assign a value to foo.serial_num would throw an Attribute Error and break stuff.
```

## Practice: Critter Chips. Sounds Delish!

Choose one of you critter classes to add a `chip_number` attribute to.
1. Update its `__init__` method with an additional parameter, `chip_num`
2. Assign `self.__chip_number` to the value of `chip_num`
3. Define a getter for `chip_number` that returns the privately scoped attribute
4. Define a setter that prevents a user from changing the value of `.chip_number`

You should then be able to do the following:

```py
finn = Goldfish("Finn", "koi fish", "goldfish flakes", 123789)

# This should not change the state of the object
finn.chip_number = 555783

# But printing it should work
print(finn.chip_number)
#prints 123789
```

## But Wait, There's More!
Another helpful use for a getter is to create dynamic properties, meaning the ability to output a value as if it were an actual property on the object, but it's really calculated at the moment it's asked for.

A common use case would be a person's name.  

There are a number of reasons why it makes sense to define a **`Person`** class with both `first_name` and `last_name` properties. Alphabetizing a whole collection of objects by last name is an obvious one. But, when using an object to output a human-readable name, it's a bit of a pain to concat `person.first_name` and `person.last_name` every time instead of `person.full_name`, right? 

Yet, physically adding a `full_name` property is redundant. You wouldn't ask someone filling out a form to type both their first, last, and full name. And think about how much space in a database that duplicate data would take up!

Fortunately, we can have the best of both worlds by defining a getter that returns both values combined for us.

```py
class Person:
    def __init__(self, first, last):
        self.first_name = first
        self.last_name = last
    
    @property
    def full_name():
        return f'{self.first_name} {self.last_name}'

wanda = Person("Wanda", "Patterbaum")
print(wanda.full_name)
# prints Wanda Patterbaum
```
# Practice: Dynamic Duo
Pick an attraction class to augment. You're going to give it the ability to produce a dynamic value that can be accessed with simple dot notation. This value will be the animal most recently added to the attraction.

1. Define a getter named `last_critter_added`
2. The function should return the last item in the attraction's animal list. Remember, Python has the ability to use negative indexes.
3. Once it's working as expected, add the same getter to the other attraction classes

You should then be able to do the following:

```py
slither_inn = SnakePit("The Slither Inn")
sammy = Anaconda("Sammy", "anaconda", "Ice Cube")
shalene = RatSnake("Shalene", "rat snake", "rats...duh")

slither_inn.add_animal(sammy)
slither_inn.add_animal(shalene)

print(slither_inn.last_critter_added)
# prints Shalene the rat snake
```
