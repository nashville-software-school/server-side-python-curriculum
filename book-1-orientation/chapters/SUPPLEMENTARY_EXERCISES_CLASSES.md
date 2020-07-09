
# Classes Exercises

## Class attributes and behaviors
### Practice: Pizza Joint

#### Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch pizza.py
```

#### Instructions
1. Create a **`Pizza`** type for representing pizzas in Python. Think about some basic properties that would define a pizza's values; things like size, crust type, and toppings would help. Define those in the `__init__` method so each instance can have its own specific values for those properties.

1. Add a method for interacting with a pizza's toppings, called `add_topping`.

1. Add a method for outputting a description of the pizza _(sample output below)_.

1. Make two different instances of a pizza. If you have properly defined the class, you should be able to do something like the following code with your Pizza type.

```py
meat_lovers = Pizza()
meat_lovers.size = 16
meat_lovers.style = "Deep dish"
meat_lovers.add_topping("Pepperoni")
meat_lovers.add_topping("Olives")
meat_lovers.print_order()
```
You should produce output in the terminal similiar to the following string.

```sh
"I would like a 16-inch, deep-dish pizza with Pepperoni and Olives."
```

## Class Construction Arguments

The `__init__()` method on a Python class can accept as many arguments as you like. Those arguments can then be used to initialize the properties of each object created from the class. Here's an example.

```py
class Farm:

    def __init__(self, name, acres):
        self.business_name = name
        self.total_acreage = acres


rolling_hills = Farm("Rolling Hills Farm", 325)
```

By passing the property value in during the instantiation of the object, I don't have to manually create the properties on a separate line of code.

```py
# No need to do this!!
rolling_hills.business_name = "Rolling Hills Farm"
rolling_hills.total_acreage = 325
```

### Practice: Urban Planner

#### Setup

```sh
mkdir -p ~/workspace/python/exercises/planner && cd $_
touch building.py
```

In this exercise, you are going to define your own **`Building`** type and create several instances of it to design your own virtual city. Create a class named **`Building`** in the `building.py` file and define the following fields, properties, and methods.

#### Properties

* `designer` - It will hold your name.
* `date_constructed` - This will hold the exact time the building was created.
* `owner` - This will store the same of the person who owns the building.
* `address`
* `stories`

#### Methods

* Define a `construct()` method. The method's logic should set the `date_constructed` field's value to `datetime.datetime.now()`. You will need to have `import datetime` at the top of your file.

* Define a `purchase()` method. The method should accept a single string argument of the name of the person purchasing a building. The method should take that string and assign it to the `owner` property.


#### Constructor

Define your `__init__` method to accept two arguments

1. `address`
2. `stories`

Once defined this way, you can send those values as  parameters when you create each instance

```py
 eight_hundred_eighth = Building("800 8th Street", 12)
 ```

#### Creating Your Buildings

1. Create 5 building instances
1. Have each one get purchased by a real estate magnate
1. After purchased, construct each one
1. Once all building are purchased and constructed, print the address, owner, stories, and date constructed to the terminal for each one.

##### Example

```sh
800 8th Street was purchased by Bob Builder on 03/14/2018 and has 12 stories.
```

## Type Relationships

You can define two types in your system that represent two real-world entities that have a relationship with each other. Consider banks and their customers. What is their relationship?

Customers usually make decisions to have an account at a single bank at a time. A bank can have many customers. This is a one-to-many relationship. In Python, you can establish this relationship by defining a list on the bank object that will contains instances of customers. Consider the following code.

```py
class Bank:

    def __init__(self, name):
        self.business_name = name
        self.customers = list()
```

When you create a bank, you specify the name of it on construction, and it get initialized with an empty list of customers.

```py
first_tennessee = Bank("First Tennessee")
```

Now define a customer.

```py
class Customer:

    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name
```

Now you can create a few people who are shopping for a bank.

```py
mo = Customer("Mo", "Silvera")
warner = Customer("Warner", "Carpenter")
ken = Customer("Ken", "Perkerwicz")
```

All three of these people choose First Tennessee as their bank, so add the object references to the `customers` list on the bank.

```py
first_tennessee.customers.append(mo)
first_tennessee.customers.append(warner)
first_tennessee.customers.append(ken)
```

Now the object have a relationship with each other. If you want to view all the customers of a bank, just iterate the `customers` list.

```py
for customer in first_tennessee.customers:
    print(f'{customer.first_name} {customer.last_name} is a customer of {first_tennessee.business_name}')
```

### Practice: Companies and Employees

#### Setup

```sh
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees_departments.py
```

#### Instructions

1. Create an **`Employee`** type that contains information about employees of a company. Each employee must have a name, job title, and employment start date.
1. Create a **`Company`** type that employees can work for. A company should have a business name, address, and industry type.
1. Create two companies, and 5 people who want to work for them.
1. Assign 2 people to be employees of the first company.
1. Assign 3 people to be employees of the second company.
1. Output a report to the terminal the displays a business name, and its employees.

For example:

```
Acme Explosives is in the chemical industry and has the following employees
   * Michael Chang
   * Martina Navritilova

Jetways is in the transportation industry and has the following employees
   * Serena Williams
   * Roger Federer
   * Pete Sampras
```

## Practice: Urban Planner II

### Setup

```sh
cd ~/workspace/python/exercises/planner
touch main.py city.py
```

In the previous Urban Planner exercise, you practices defining custom types to represent buildings. Now you need to create a type to represent your city. Here are the requirements for the class. You define the properties and methods.

1. Name of the city.
1. The mayor of the city.
1. Year the city was established.
1. A collection of all of the buildings in the city.
1. A method to add a building to the city.

Remember, each class should be in its own file. Define the **`City`** class in the `city.py` file.

### Importing into Main

Open the `main.py` file and import the **`Building`** class from `building.py`. Once you have defined your **`City`** class, also import that into `main.py`. For this exercise, all the logic of constructing buildings and building your city will be in `main.py`, so take all of your logic from `building.py` and move it over to main.

> ##### `main.py`

```py
from building import Building
from city import City
```

### Birth of a City

Create a new city instance and add your building instances to it. Once all buildings are in the city, iterate the city's building collection and output the information about each building in the city.

> ##### `main.py`

```py
megalopolis = City()

# Awesome code here

for building in megalopolis.buildings:
    print(building)
```

### Practice: Companies and Employees

#### Setup

```sh
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees_departments.py
```

#### Instructions

1. Create an **`Employee`** type that contains information about employees of a company. Each employee must have a name, job title, and employment start date.
1. Create a **`Company`** type that employees can work for. A company should have a business name, address, and industry type.
1. Create two companies, and 5 people who want to work for them.
1. Assign 2 people to be employees of the first company.
1. Assign 3 people to be employees of the second company.
1. Output a report to the terminal the displays a business name, and its employees.

For example:

```
Acme Explosives is in the chemical industry and has the following employees
   * Michael Chang
   * Martina Navritilova

Jetways is in the transportation industry and has the following employees
   * Serena Williams
   * Roger Federer
   * Pete Sampras
```

## Practice: Urban Planner II

### Setup

```sh
cd ~/workspace/python/exercises/planner
touch main.py city.py
```

In the previous Urban Planner exercise, you practices defining custom types to represent buildings. Now you need to create a type to represent your city. Here are the requirements for the class. You define the properties and methods.

1. Name of the city.
1. The mayor of the city.
1. Year the city was established.
1. A collection of all of the buildings in the city.
1. A method to add a building to the city.

Remember, each class should be in its own file. Define the **`City`** class in the `city.py` file.

### Importing into Main

Open the `main.py` file and import the **`Building`** class from `building.py`. Once you have defined your **`City`** class, also import that into `main.py`. For this exercise, all the logic of constructing buildings and building your city will be in `main.py`, so take all of your logic from `building.py` and move it over to main.

> ##### `main.py`

```py
from building import Building
from city import City
```

### Birth of a City

Create a new city instance and add your building instances to it. Once all buildings are in the city, iterate the city's building collection and output the information about each building in the city.

> ##### `main.py`

```py
megalopolis = City()

# Awesome code here

for building in megalopolis.buildings:
    print(building)
```
***************************************
## Getters and Setters

### Practice: Solid Student

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

***************************************


# Inheritance
## Gary's Wholesale Garage

You are going to use the vehicle classes from Gary's Wholesale Garage from the last chapter to learn about the basics of inheritance. Here's the code from the last chapter.

When considering interfaces, you examine your code to look for properties and methods that **some** of the classes have in common. When considering inheritance, you examine your code to look for properties and methods that **all** of the classes have in common.

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

As you add more vehicle types to your system, it would get very tedious to keep defining those properties in each of those classes. It would also increase the possibililty of bugs being introduced. If your team decided to change the `main_color` property to renamed to `base_color`, all of the classes would need to be changed. Since human beings are highly prone to error, a class could be missed during refactoring.

To avoid these kinds of problems, you are going to create a more general type in your system and then have all vehicles inherit from it.

## Vehicle Class

Since all of the types are vehicles, a good name for this new type would be `Vehicle`.


```py
class Vehicle:
    def __init__(self):
        self.main_color = ""
        self.maximum_occupancy = ""
```

Then each of the other, more specific, types would inherit from it. The syntax for inheritance is to specify the parent class in parenthesis after the class definition.

```py
class Tesla(Vehicle):
    def __init__(self):
        self.battery_kwh = 0

    def charge_battery(self):
        ...
```

Now any instance of `Tesla` will have both of those properties on it automatically.

## Overriding Parent Behavior

To this point, you've seen how to inherit common properties from a parent class, and now you're going to implement a behavior on a parent class. Each child class will automatically inherit it, but then **_override_** the default logic.

You can safely assume that each vehicle can be driven. What you would then do is implement a `drive()` method on the **`Vehicle`** class.


```py
class Vehicle:
    def __init__(self):
        self.main_color = ""
        self.maximum_occupancy = ""

    def drive(self):
        print("Vroooom!")
```

Once you do this, all of the specific vehicles can be driven. For now, however, they will all make the same sound, which is ridicuous because a plane doesn't sound like a truck which doesn't sound like a motorcycle.

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


Now you can run the program again and the Tesla will make a different noise.

## Practice: Custom Colors and Sounds

1. Define 5 of your favorite vehicles
1. Move all common properties in your vehicles to a new **`Vehicle`** class.
1. Create an instance of each vehicle.
1. Define a different value for each vehicle's properties.
1. Create a `drive()` method in the **`Vehicle`** class.
1. Override the `drive()` method in all the other vehicle classes. Include the vehicle's color in the message _(i.e. "The blue Ram drives past. RRrrrrrummbbble!")_.
1. Create a `turn(self, direction)` method, and a `stop(self)` method on **`Vehicle`**. Define a basic implementation of each.
1. Override all three of those methods on some of the vehicles. For example, the `stop()` method for a plane would be to output the message _"The white Cessna rolls to a stop after rolling a mile down the runway."_
1. Make your vehicle instances perform all three behaviors.

# Inheritance Practice
## Uncle Jake's Flower Shop

Uncle Jake (a.k.a. Jake Mendenhyll) opened his flower shop in 1972, at the height of the Flower Power cultural phenomenon. Since then, his two daughters, and 1 grandson have joined him in running the shop.

Their two biggest seasons are Mother's Day and Valentine's Day. Throughout Denver, the tradition of sending an Uncle Jake arrangement has passed across generations, and people trust Jake and his family to send the best flowers. Since 1980, the contents of each arrangement has never changed.

#### Mother's Day Arrangement

The Mother's Day arrangement contains daisies, baby's breath, and poppies. This arrangement is a bit more reserved, and Jake makes sure that each flower stem is cut to 4 inches.

Also, each flower in this arrangement is organically grown with no pesticides used. Because of this, these arrangements have to be transported in a non-refrigerated container.

#### Valentine's Day Arrangement

The Valentine's Day arrangement includes the traditional rose. Jake has red, pink, and blue ones to send the right message. It also has lillies and alstroemeria to add more depth to the color of the arrangement.

This arrangment is flamboyant and extravagent. Each flower stem is cut to 7 inches. Flowers in this arrangement are not organically grown, so they can be transported in a refrigerated container.

#### Instructions

Your task is to define classes for each type of flower, and a class for each arrangement type. Each arrangement instance should have an attribute of `flowers` which will contain at least one of each type of the corresponding flowers listed above.

Your code must ensure that only the right flowers can be added to each arrangement. Here's some terse starter code.

* Rose, lillies, and alstroemeria share some attribute that the others do not _(perfect case for an interface class)_
* All flowers share some common attributes


```py
class Arrangement:

    def __init__(self):
        self.__flowers = []

    def enhance(self, flower):
        self.__flowers.append(flower)


class MothersDay(Arrangement):

    def __init__(self):
        super().__init__()

class ValentinesDay(Arrangement):
    def __init__(self):
        super().__init__()
     
    # Override the `enhance` method to ensure only
    # roses, lillies, and alstroemeria can be added


class Rose:
    pass

if __name__ == "__main__":
    for_beth = ValentinesDay()
    red_rose = Rose()

    for_beth.flowers.append(red_rose)
```

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
