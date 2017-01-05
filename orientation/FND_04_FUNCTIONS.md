# Functions

Just like JavaScript functions, but the syntax is different and white space matters. You indent the contents of the function.

```python
def display_name(name):
    print(name)

display_name('Josephina')
```

You can define documentation for a function. This is highly encouraged.

```
>>> def display_name(name):
...     '''Displays a name
... 
...     Arguments:
...     name -- a string to be printed
...     '''
...     print(name)
... 
>>> display_name('Josephina')
Josephina
>>> 
>>> print(display_name.__doc__)
Displays a name

    Arguments:
    name -- a string to be printed

```
