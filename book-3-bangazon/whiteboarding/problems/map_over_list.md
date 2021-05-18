# Map Over Lists

Write a function that takes two parameters. The first parameter should be a list of lists. The second should be a lambda function.
The function should map the lambda function over the contents of the inner lists

## Examples
```py
# Integer Example
x = [[1,2,3],
     [4,5,6]]
     
grid_map(x, lambda x: x + 1)
-- returns [[2,3,4],[5,6,7]]

# String Example
x = [['h', 'E', 'l', 'l', 'O'], ['w', 'O', 'r', 'L', 'd']]
grid_map(x, lambda x: x.upper())
-- returns [['H', 'E', 'L', 'L', 'O'], ['W', 'O', 'R', 'L', 'D']]
```

### Need a hint?
You'll need 2 `for..in` loops. The first one to loop over the list parameter and the second loop for the inner lists. You can call lambda functions like a regular function

### Finished?
Refactor your solution, try writing it as a list comprehension
