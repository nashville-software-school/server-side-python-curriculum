# Not Hello, World

## Setup

Here's your very first Python code module. Go ahead and create a new directory for storing your Python code and create a file named `humansizes.py`.

```
mkdir ~/workspace/python/intro && cd $_
touch humansizes.py
subl .
```

Next, copy pasta the code in the [humansizes.py](exercises/assets/humansizes.py) into yours. The first thing you might notice is the lack of curly braces defining the beginning and ending of a block of logic. In Python, indentation is king. Whitespace matters, unlike in JavaScript.

## Running a Module of Code

In your CLI, execute the module of code by typing `python humansizes.py`.

## Code Review

Let's take a look at the code.

```python
① SUFFIXES = {1000: ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            1024: ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']}

② def approximate_size(size, a_kilobyte_is_1024_bytes=True):

    '''Convert a file size to human-readable form.

    (this is a docstring)

    Keyword arguments:
    size -- file size in bytes
    a_kilobyte_is_1024_bytes -- if True (default), use multiples of 1024
                                if False, use multiples of 1000

    Returns: string

    '''
③   if size < 0:
        raise ValueError('number must be non-negative')

④   multiple = 1024 if a_kilobyte_is_1024_bytes else 1000
    for suffix in SUFFIXES[multiple]:
        size /= multiple
        if size < multiple:
            return '{0:.1f} {1}'.format(size, suffix)

    raise ValueError('number too large')

if __name__ == '__main__':
⑤   print(approximate_size(16384, False))
    print(approximate_size(size=16384, a_kilobyte_is_1024_bytes=False))
    print(approximate_size(-16384))
```

> ☞ Like JavaScript, Python is a dynamically typed language, meaning that the compiler determines the type of a variable at run-time.

① This looks like an object from JavaScript, but in Python Land, it's called a dictionary

② In JavaScript, you used the `function` to define functions, but in Python, it's `def`. Just like in JavaScript, functions are first-class objects and can be passed to other functions.

③ For `if` and `for` blocks, you don't use {} to define the block scope. You use a colon, and then indent the corresponding code.

④ This is the style for writing a ternary condition in Python.

⑤ The `print()` method is Python's `console.log()`

## The `__name__` of a Module

Since everything in Python is an object, this entire module of code is an object when you execute it in the CLI. It automatically gets a `__name__` property, whose value is `__main__` because it was executed independently.

When you learn about importing modules, you will learn how the `__name__` value will change in that situation.
