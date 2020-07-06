# Python Tuples

Tuples are like lists, but are immutable. They can't be modified once defined. However, finding values in a tuple is faster than in a list.

```py
# Tuples (ordered, immutable & allows duplicates)

my_tup = (1, 2, 3, 3, "hello")
print(my_tup)

# Immutable means you cannot change the tuple once it's been created: no changing an existing value, no adding new values, no removing values!
my_tup[0] = "new value"
print(my_tup[0])
print(my_tup[-2])

# Loop through the values in the tuple
for value in my_tup:
    print(value)

# You CAN reassign a variable to a new tuple, though.
my_tup = ("I'm thirsty", "I'm hungry")
print(my_tup)

# If you have one value in a tuple, you have to follow it with a comma! 
my_little_tup = ("hello",)

print(isinstance(my_little_tup, tuple))
print(type(my_little_tup))
```

## Setup

```sh
mkdir -p ~/workspace/python/exercises/tuples && cd $_
touch zoo.py
code .
```

## References

* [Python tuples](https://docs.python.org/3.6/tutorial/datastructures.html#tuples-and-sequences)
* [Introducing Tuples](http://www.diveintopython.net/native_data_types/tuples.html)

## Instructions

1. Create a tuple named `zoo` that contains 10 of your favorite animals.
1. Find one of your animals using the `tuple.index(value)` syntax on the tuple.
    ```py
    # Example
    flowers = ("daisy", "rose")
    flower.index("rose") # Output is 1
    ```
1. Determine if an animal is in your tuple by using `value in tuple` syntax.
    ```py
    animal_to_find = "kangaroo"
    if animal_to_find in zoo:
        # Print that the animal was found
    ```
1. You can reverse engineer (unpack) a tuple into another tuple with the following syntax.
    ```py
    children = ("Sally", "Hansel", "Gretel", "Svetlana")
    (first_child, second_child, third_child, fourth_child) = children
    print(first_child) # Output is "Sally"
    print(second_child) # Output is "Hansel"
    print(third_child) # Output is "Gretel"
    print(fourth_child) # Output is "Svetlana"
    ```
    Create a variable for the animals in your zoo tuple, and print them to the console.
1. Convert your tuple into a list.
1. Use `extend()` to add three more animals to your zoo.
1. Convert the list back into a tuple.
