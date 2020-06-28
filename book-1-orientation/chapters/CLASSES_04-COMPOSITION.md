<!-- TODO: Refactor for Critters -->

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
