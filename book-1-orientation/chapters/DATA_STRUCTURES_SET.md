# Python Sets

A set is a collection of things, like a list, but the collection is both unordered, and contains no duplicate elements. Developers use sets to easily filter down other collections to unique elements, and to see if two, or more, collections share any similar items.

You can create a set in one of two ways.

```py
# Using set() to create a set
languages = set()

# Using curly braces allows you to initialize the set with values
languages = { 'english', 'mandarin chinese', 'spanish', 'english', 'spanish', 'portugese' }
```

Notice that both of those sets were constructed with some duplicate items. However, when you print out the set, the duplicates are gone.

```py
>>> print(languages)
{'english', 'mandarin chinese', 'portugese', 'spanish'}
```

## Setup

```
mkdir -p ~/workspace/python/exercises/sets && cd $_
touch cars.py
```

## References

* [Python sets](https://docs.python.org/3.6/tutorial/datastructures.html#sets)
* [Set intersection](https://docs.python.org/3.6/library/stdtypes.html?highlight=intersection#set.intersection)
* [Learn Python - Sets](http://www.learnpython.org/en/Sets)

## Practice: Showroom & Junkyard

1. Create an empty set named `showroom`.
1. Add four of your favorite car model names to the set.
1. Print the length of your set.
1. Pick one of the items in your show room and add it to the set again.
1. Print your showroom. Notice how there's still only one instance of that model in there.
1. Using `update()`, add two more car models to your showroom with another set.
1. You've sold one of your cars. Remove it from the set with the `discard()` method.

### Acquiring more cars

1. Now create another set of cars in a variable `junkyard`. Someone who owns a junkyard full of old cars has approached you about buying the entire inventory. In the new set, add some different cars, but also add a few that are the same as in the `showroom` set.
1. Use the `intersection` method to see which cars exist in both the showroom and that junkyard.
1. Now you're ready to buy the cars in the junkyard. Use the `union` method to combine the junkyard into your showroom.
1. Use the `discard()` method to remove any cars that you acquired from the junkyard that you do not want in your showroom.

## Advanced Challenge: Matching Makes & Models

### Setup

```
mkdir -p ~/workspace/python/challenges/sets-car-challenge && cd $_
touch cars.py
```

Place the following code into **cars.py**.

```
makes = (
  (1, "Toyota"), (2, "Nissan"),
  (3, "Ford"), (4, "Mini"),
  (5, "Honda"), (6, "Dodge"),
)

models = (
  (1, "Altima", 2), (2, "Thunderbird", 3),
  (3, "Dart", 6), (4, "Accord", 5),
  (5, "Prius", 1), (6, "Countryman", 4),
  (7, "Camry", 1), (8, "F150", 3),
  (9, "Civic", 5), (10, "Ram", 6),
  (11, "Cooper", 4), (12, "Pilot", 5),
  (13, "Xterra", 2), (14, "Sentra", 2),
  (15, "Charger", 6)
)

colors = (
  (1, "Black" ), (2, "Charcoal" ), (3, "Red" ), (4, "Brick" ),
  (5, "Blue" ), (6, "Navy" ), (7, "White" ), (8, "Ivory" )
)

available_car_colors = (
  (1, 1), (1, 2), (1, 7),
  (2, 1), (2, 3), (2, 7),
  (3, 2), (3, 3), (3, 7),
  (4, 3), (4, 5), (4, 8),
  (5, 2), (5, 4), (5, 8),
  (6, 2), (6, 6), (6, 7),
  (7, 1), (7, 3), (7, 7),
  (8, 1), (8, 5), (8, 8),
  (9, 1), (9, 6), (9, 7),
  (10, 2), (10, 5), (10, 7),
  (11, 3), (11, 6), (11, 8),
  (12, 1), (12, 4), (12, 7),
  (13, 2), (13, 6), (13, 8),
  (14, 2), (14, 5), (14, 8),
  (15, 1), (15, 4), (15, 7)
)
```

### Overview

This is an advanced challenge because it requires multiple layers of iteration. It is also an introduction to database relationships because there are four unique collections that are all related to each other.

In the `makes` and `colors` collections, each item has a numeric identifier, and then a string representation.

##### Example

```
(1, "Toyota")
```

In the `models` collection, each item also has a numeric identifier, but also stores the numeric identifier of a model

##### Example

```
(5, "Prius", 1)
# 5 is the numeric identifier for a Prius
# 1 is the numeric identifier to a foreign collection item... Toyota
```

Finally, the `available_car_colors` collection is storing the relationships between items in two foreign collections. The first number represents the corresponding model, and the second number represents the corresponding color.

##### Example
```
(1, 7)
# This represents a relationship between "Altima" and "White"
```

### Instructions

#### Part 1: Reporting Object

You must first build a new dictionary that follows the format below.

1. Each key in the dictionary should be the name of a make, and its value will be a dictionary.
1. The keys in the make dictionary will be the models, and the value will be a list of colors in which that the model is available.

```
{
    'Toyota': {
      'Prius': ['Charcoal', 'Brick', 'Ivory'],
      'Camry': ['Black', 'Red', 'White']
    },
    'Nissan': {
      'Sentra': ['Charcoal', 'Blue', 'Ivory'],
      'Altima': ['Black', 'Charcoal', 'White'],
      'Xterra': ['Charcoal', 'Navy', 'Ivory']
    },
    'Mini': {
      'Countryman': ['Charcoal', 'Navy', 'White'],
      'Cooper': ['Red', 'Navy', 'Ivory']
    },
    'Ford': {
      'F150': ['Black', 'Blue', 'Ivory'],
      'Thunderbird': ['Black', 'Red', 'White']
    },
    'Honda': {
      'Civic': ['Black', 'Navy', 'White'],
      'Pilot': ['Black', 'Brick', 'White'],
      'Accord': ['Red', 'Blue', 'Ivory']
    },
    'Dodge': {
      'Ram': ['Charcoal', 'Blue', 'White'],
      'Charger': ['Black', 'Brick', 'White'],
      'Dart': ['Charcoal', 'Red', 'White']
    }
}
```

#### Part II - Command Line Report

Output a report on the command line that looks like this.

```
Ford
------------------
F150 available in Black, Blue, Ivory
Thunderbird available in Black, Red, White

etc...
```

## Black Hat Hacker Challenge

Rewrite your nested `for` loops as nested comprehensions.