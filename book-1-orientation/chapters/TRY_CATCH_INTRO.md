# Basic Exception Handling

There are many scenarios in python that can cause your code to stop running.
If python notices some code that is structured incorrectly, or is not abiding by some of it's rules, it will throw an `Exception`.
This is python's way of telling you that something bad just happened.

Let's look at some basic code and see what harmful side-effects can happen.

```python
def get_index_of_item(a_list, value):
    """Return the index of 'value' in 'a_list'
    
    Arguments:
        a_list - A list of elements
        value  - Any item that could be in the list
    """
    return a_list.index(value)
```

Python `lists` have a method called `index` that will return the index of the value in that list.
However, what happens when you try to get the index of a value that is _not_ in the list?

```python
my_list = [1, 2, 3, 4]
get_index_of_item(my_list, 5)
```

This will raise a `ValueError` exception because the logic for the `get_index_of_item()` assumes that the value exists in the list, in this case it doesn't, so Python will yell at us.

So we need to think about these kinds of issues when writing our code instead of assuming the the code that invokes this method will *always* do the correct thing. 
We need implement exception handling so that a useful exception is raised to the invoking code, or different logic gets implemented when a certain exception shows up.

Let's look at how to do that with `try...except` blocks.

```python
def get_index_of_item(a_list, value):
    """Return the index of 'value' in 'a_list'
    
    Arguments:
        a_list - A list of elements
        value  - Any item that could be in the list
    """
    try:
        return a_list.index(value)

    except ValueError:
        print(f'{value} is not in the list.')
        return -1
```

Now, if an incorrect type of value is passed, a human-friendly message is output to the console and `-1` is returned to the implementer rather than the actual index. 

