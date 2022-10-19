# Add Multiples of 3 and/or 5

Write a function that that takes a positive integer as a parameter. The function should return the sum of all the multiples of 3 and/or 5 less than (but not equal to) the number passed in

## Example

```py
sum_of_multiples(10)
# returns 23
# 3 + 5 + 6 + 9
```

## Starter code

```py
def sum_of_multiples(num):
    # add your solution here
    pass

def test_sum_of_multiples_solution():
    assert sum_of_multiples(10) == 23
    assert sum_of_multiples(20) == 78
    assert sum_of_multiples(0) == 0
    assert sum_of_multiples(1) == 0
    assert sum_of_multiples(200) == 9168
    assert sum_of_multiples(64) == 933
```

## Need a hint?

You'll need to create an iterable (something that can be looped over ie. `List`) of the numbers below the parameter. Look up the `range` function and `modulo` operator

## Finished?

Refactor to use a list comprehension
