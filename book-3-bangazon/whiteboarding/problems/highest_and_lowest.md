### Highest and Lowest
Write a function that takes a string of comma separated numbers and returns the highest and lowest number as a dictionary

## Examples

```py
highest_and_lowest("4, 7, 55555, -29834, 89")
# Returns
{
    'highest': 55555,
    'lowest': -29834
}
```

## Starter Code
```py
def highest_and_lowest(string_o_numbers):
    # add your solution here
    pass

def test_highest_and_lowest_solution():
    assert highest_and_lowest('5 4 3 9 7 23') == { 'highest': 23, 'lowest': 3 }
    assert highest_and_lowest('4 5 29 54 4 0 -214 542 -64 1 -3 6 -6') == { 'highest': 542, 'lowest': -214 }
    assert highest_and_lowest('1 -1') == { 'highest': 1, 'lowest': -1 }
    assert highest_and_lowest('42') == { 'highest': 42, 'lowest': 42 }
    assert highest_and_lowest('2189 3105 476 2849 1619 1816 1785 1037 3266 187 446 3032 1743 2940 535 1677 2176 968 176 2078 2404 2867') == { 'highest': 3266, 'lowest': 176 }

```




### Need a hint?
Look up how to use the `max` and `min` functions in python
### Finished?
Try writing your own `min` and `max` functions instead of using the built-in functions
