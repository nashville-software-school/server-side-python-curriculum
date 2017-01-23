# Squared Randoms

## Setup

```
mkdir -p ~/workspace/python/exercises/lists && cd $_
touch random_squared.py
```

## References

* [Random module](https://docs.python.org/3.6/library/random.html)
* [Python Lists](https://docs.python.org/3.6/tutorial/datastructures.html)

## Instructions

1. Using the `random` module and the `range` method, generate a list of 20 random numbers between 0 and 49.
    ```
    import random

    random_numbers = [...insert awesome code here...]
    print(random_numbers)
    ```
2. With the resulting list, use a list comprehension to build a new list that contains each number squared. For example, if the original list is `[2, 5]`, the final list will be `[4, 25]`.