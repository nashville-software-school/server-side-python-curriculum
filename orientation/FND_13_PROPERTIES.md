# Python Getters and Setters (Accessors and Mutators)

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

Since Python is dynamically typed, simple attributes have no way of enforcing what value they accept. Fortunely, the language provides a way for you to check and enforce value restrictions - the `@property` decorator.


```py
class Product():

    @property
    # The getter (accessor)
    def price(self):
        try:
            return self.__price
        except AttributeError:
            return 0

    @quantity.setter
    # The setter (mutator)
    def price(self, new_price):
        if isinstance(new_price, float):
            self.__price = new_price
        else:
            raise TypeError('Please provide a floating point value for the price')
```

Now you have set a type check on what the value of the `price` attribute can be.

```py
p = Product()
p.price = 1

>>> TypeError: Please provide a floating point value for the price
```

Now set the value to a floating point decimal.

```py
p = Product()
p.price = 1.0 # Everything works ok
```
