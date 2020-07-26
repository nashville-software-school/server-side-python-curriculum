# Python Lists

A list is the new array from JavaScript. They are collections of similar items. The syntax is identical to JavaScript's array.

```py

# Lists (ordered, mutable & allows duplicates)

animals = ["Jack", "Noonan", "Blue", "Gypsy"]

junk = ["Fred", True, [1, 2, 3], 234]

# Adding items to the list
junk.append(234)
junk.insert(0, "oh, I get it")
print(junk)
junk.extend(["Mary", "Joseph", "Bob"])
print(junk)

# Negative indexing
junk[-1] = "The last item"
print(junk[-4])

# Loop through the items in a list
for taco in junk:
    print(taco)

# Javascript equivalent: junk.forEach(taco => console.log(taco));

# You can declare an empty list:
stuff = []

# Create a NEW list from a subset of values in another list with slice
my_list = [1, 2, 4, "hello", "monkey"]
my_subset = my_list[0:3]
my_subset = my_list[1:3]
my_subset = my_list[:3]
my_subset = my_list[2:]
print(my_subset)
print(my_list)
```

## Reference

* [Python Lists](https://docs.python.org/3.6/tutorial/datastructures.html)
* [Learn Python - Lists](http://www.learnpython.org/en/Lists)

## Practice: Random Numbers

### Instructions

1. Use the following code to create a list of 10 random numbers. Each number will be between 0 and 6.
    ```py
    import random

    my_randoms = list()
    for i in range(10):
        my_randoms.append(random.randrange(1, 6))
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
        my_randoms.append(random.randrange(1, 6))

    # Generate a list of numbers 1..10
    numbers_1_to_10 = range(1, 11)

    # Iterate from 1 to 10
    for number in numbers_1_to_10:
        the_numbers_match = False

        # Iterate your random number list here

        # Does my_randoms contain number? Change the boolean.

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
