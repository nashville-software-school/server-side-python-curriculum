# Python Lists

## Setup

First, open up your Terminal or Command Prompt.
Then, paste in this command: 

```sh
mkdir -p ~/Documents/python/orientation && cd $_
jupyter notebook
```

Create a _new_ notebook labelled `Chapter 3` using the `python3` option.

## Lists

Lists are one of the more common data types that you will come across.
They serve as simple containers that can hold objects.
They are collections of similar items, like a grocery list.

```py
groceries = ["milk", "bread", "flashlight", "blizzard survival guide"]
numbers = [1, 2, 3, 4, 5]
random_values = ["foo", 1, True, None]
```

The only special syntax for the list is the _square brackets_ `[]`.
Every element in the list is separated by a comma.

## Accessing Elements

Ok, so you have a list. 
How do you get at the different values within the list?
How can you get the first element?
The last element?
The first 5 elements???
Last 3?
Every other?

So many questions!
Only one answer.
By _slicing_ the list at it's _indices_.

**Python starts at the number 0**.
It is **zero-indexed**.

So, with that in mind, every element in a list is automatically assigned a number, starting with zero.
Let's take an example: 
```python
fruits = ['orange', 'apple', 'pear', 'banana', 'kiwi', 'apple', 'banana']
```

Every fruit has an index (0-6): 
* 'orange': 0
* 'apple': 1
* 'pear': 2 
* 'banana': 3
* 'kiwi': 4
* 'apple': 5
* 'banana': 6

The index is _ALWAYS_ sequential, and updates when items get added or removed from the list.
If we were to shuffle this list and mix up the values, the indices will still be 0-6.


  

### List Methods

Just like strings, lists also have _methods_ that we can use.

```python
fruits = ['orange', 'apple', 'pear', 'banana', 'kiwi', 'apple', 'banana']
```

* `count` - Shows how many times something shows up in my list
* `index` - At which position does something show up in my list
* `reverse` - Reverse it!
* `append` - Adds something to the end of the list
* `sort` - Sorts it
* `pop` - remove an element from the end of the list

Go ahead and stick this in a cell and run it. 
See what happens to our list!
```python
print(fruits.count('apple'))
print(fruits.count('tangerine'))
print(fruits.index('banana'))
print(fruits.index('banana', 4))  # Find next banana starting a position 4

fruits.reverse()
print(fruits)

fruits.append('grape')
print(fruits)

fruits.sort()
print(fruits)

print(fruits.pop())
print(fruits)
```

Of course, these are _just a few methods_.
There are [many more](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists).

## Some References

* [Python Lists](https://docs.python.org/3.6/tutorial/datastructures.html)
* [Learn Python - Lists](http://www.learnpython.org/en/Lists)

## Practice: Random Numbers

### Instructions

1. Use the following code to create a list of 10 random numbers. Each number will be between 0 and 6.
    ```py
    import random

    my_randoms = list()
    for i in range(10):
        my_randoms.append(random.randrange(1, 6, 1))
    ```

    The `my_randoms` list will now contain random numbers
    ```py
    [1, 3, 1, 2, 4, 2, 5, 4, 2, 5]
    ```

1. Then iterate a different list of numbers that are sequential from 1 to 10. Use the following code as your starting point.

    ```py
    import random
    """
    Print a message to the console indicating whether each value of
    `number` is in the `my_randoms` list.
    """

    my_randoms = list()
    for i in range(10):
        my_randoms.append(random.randrange(1, 6, 1))

    # Generate a list of numbers 1..10
    numbers_1_to_10 = range(1, 10)

    # Iterate from 1 to 10
    for number in numbers_1_to_10:
        the_numbers_match = False

        # Iterate your random number list here

        # Do the two numbers match? Change the boolean.

        print(f'{number} is in the random list')
    ```

#### Example Output in the Terminal

```sh
my_randoms list contains 0
my_randoms list does not contain 1
my_randoms list does not contain 2
my_randoms list contains 3
my_randoms list contains 4
my_randoms list does not contain 5
```

> **NOTE:** Each run will produce different output.



## Practice: Planet List

### Setup

```sh
mkdir -p ~/workspace/python/lists && cd $_
echo 'planet_list = ["Mercury", "Mars"]' >> planets.py
```

### Instructions

1. Use `append()` to add Jupiter and Saturn at the end of the list.
1. Use the `extend()` method to add another list of the last two planets in our solar system to the end of the list.
1. Use `insert()` to add Earth, and Venus in the correct order.
1. Use `append()` again to add Pluto to the end of the list.
1. Now that all the planets are in the list, slice the list in order to get the rocky planets into a new list called `rocky_planets`.
1. Being good amateur astronomers, we know that Pluto is now a dwarf planet, so use the `del` operation to remove it from the end of `planet_list`.

## Challenge: Iterating over planets

1. Create another list containing tuples. Each tuple will hold the name of a spacecraft that we have launched, and the names of the planet(s) that it has visited, or landed on.
    ```py
    # Example spacecraft list
    spacecraft = [
       ("Cassini", "Saturn"),
       ("Viking", "Mars"),
    ]
    ```
1. Iterate over your list of planets, and inside that loop, iterate over the list of tuples. Print, for each planet, which satellites have visited it.
