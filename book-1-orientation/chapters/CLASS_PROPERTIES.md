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

## "Private" Variables

The `self.__price` is considered a privately scoped attribute and should not be accessed. It is obfuscated by Python to not show up as an attribute. There is a method in Python named `dir()`. It returns a list of valid attributes of the object. Look at what the valid attributes are for the object referenced by `p`.

```py
print(dir(p))

['__class__', '__delattr__', '__dict__', '__dir__',
 '__doc__', '__eq__', '__format__', '__ge__',
 '__getattribute__', '__gt__', '__hash__', '__init__',
 '__init_subclass__', '__le__', '__lt__', '__module__',
 '__ne__', '__new__', '__reduce__', '__reduce_ex__',
 '__repr__', '__setattr__', '__sizeof__', '__str__',
 '__subclasshook__', '__weakref__', 'price']
 ```

 Note that `price` is in that list, but `__price` is not. Therefore, even though you, as the class designer, know that `__price` exists, you should not try to access it on an instance of the class.

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

## Practice: Sensitive Information

Create a class to represent a patient of a doctor's office. The **`Patient`** class will accept the following information during initialization

1. Social security number
1. Date of birth
1. Health insurance account number
1. First name
1. Last name
1. Address

The first three properties should be read-only. First name and last name should not be exposed as properties at all, but instead expose a calculated property of `full_name`. Address should have a getter and setter.

```py
cashew = Patient(
    "097-23-1003", "08/13/92", "7001294103",
    "Daniela", "Agnoletti", "500 Infinity Way"
)

# This should not change the state of the object
cashew.social_security_number = "838-31-2256"

# Neither should this
cashew.date_of_birth = "01-30-90"

# But printing either of them should work
print(cashew.social_security_number)   # "097-23-1003"

# These two statements should output nothing
print(cashew.first_name)
print(cashew.last_name)

# But this should output the full name
print(cashew.full_name)   # "Daniela Agnoletti"



```
