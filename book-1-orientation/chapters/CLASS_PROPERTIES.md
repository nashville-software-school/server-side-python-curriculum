# Python Class Properties

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
p = Product()
p.price = 1

>>> TypeError: Please provide a floating point value for the price
```

Now set the value to a floating point decimal.

```py
p = Product()
p.price = 1.0 # Everything works ok
```

## Practice: Solid Student

Define a Python class named `Student`. This class will have 5 properties.

1. First name (string)
1. Last name (string)
1. Age (integer)
1. Cohort number (integer)
1. Full name (read-only string)

* Define getters for all properties.
* Define a setter for all but the read only property.
* Ensure that only the appropriate value can be assigned to each.
* The full name property should return first name and last name separated by a space. It's value cannot be set.

## Practice: Convert Student Object to a String

Use the [`__str__` and `__repr__`](https://realpython.com/lessons/how-and-when-use-__str__/) magic methods on your class to specify what an object's string representation should be. It's just like the `toString()` method in JavaScript.

If you print a `Student` object. The output would look something like below.

```py
mike = Student()
mike.first_name = "Mike"
mike.last_name = "Ellis"
mike.age = 35
mike.cohort_number = 39

print(mike)
<__main__.Student object at 0x107133f60>
```

But if you specify exactly what string should be returned from `__str__` or `__repr__`, that will print out instead. If you implement the following method on your class...

```py
class Student:

    def __str__(self):
        return f"{self.full_name}"
```

then the output will change

```py
print(mike)
Mike Ellis
```

Change your class so that any objects created from it will be rerpesented as strings in the following format.

```haml
Mike Ellis is 35 years old and is in cohort 39
```
