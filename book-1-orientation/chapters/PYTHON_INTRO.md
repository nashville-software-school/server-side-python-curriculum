# Not Hello, World

## Setup

Here's your very first Python code module. Go ahead and create a new directory for storing your Python code and create a file named `humansizes.py`.

```sh
mkdir -p ~/workspace/python/intro && cd $_
jupyter notebook
```

Go ahead and create a new notebook, and call it `humansizes`.

Next, copy the following snippets into your notebook, one cell each.

## Code Review

Let's take a look at the code.

```python
① SUFFIXES = {1000: ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            1024: ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']}
```
```python
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
```
```python
⑤ print(approximate_size(16384, False))
print(approximate_size(size=16384, a_kilobyte_is_1024_bytes=False))
print(approximate_size(-16384))
```

> ☞ Python is a dynamically typed language, meaning that the compiler determines the type of a variable at run-time.

① This is called a dictionary. Everything to the left of the colon is considered a _key_, while everything on the right side of the colon is called a _value_. `{key: value}`

② In Python, you use the `def` keyword to define functions. Functions are first-class objects and can be passed to other functions.

③ For `if` and `for` blocks, you use a colon to define block scope, and then indent the corresponding code.

④ This is how you write a bite-sized conditional (ternary) in python! One line!

⑤ The `print()` method let's will "print" output to your console.

## Python Modules

Typically, you will want to use some tools to accomplish what you are trying to do.
Your "tools" can be found in "toolbags", called _modules_. 
Here is how you can import a module.

```py
# import toolbag
# import module
import http
import sys
import student
import instructor
```

Here is how you can import a specific "tool", (_function_), from a module.

```py
# from toolbag import tool
# from module import function
from food_factory import factory
```

Python will look in every directory that is defined in `sys.path` for a file, or executable, that matches the name in your import statement. If you ever want to see those locations, you can just print them and take a look. As a test, add this to your `humansizes.py` file

```py
import sys
print(sys.path)
```
In the AREPL window, you would see something like
> ['', '/Users/student/.pyenv/versions/3.4.3/lib/python34.zip', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4/lib-dynload', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4/site-packages']

## Import Your Module

Python will also look in the immediate directory for any files matching what you want to import. After it's imported, you can call any method in that module. Just precede it with the module name.

```py
import module

module.function_name(arguments)
```

In the same directory as `humansizes.py`, create another file, `index.py`. In it, import the `humansizes` module

```py
import humansizes
print(humansizes.approximate_size(80808080, True))
```
In AREPL you'll see the number, such as `77.1 MiB`

## Function Docstrings

If you ever want to see the developer's documentation of a function, you can access the built-in `__doc__` property on the function.

```
>>> print(humansizes.approximate_size.__doc__)

Convert a file size to human-readable form.

    Keyword arguments:
      size                     -- file size in bytes
      a_kilobyte_is_1024_bytes -- if True (default), use multiples of 1024
                                if False, use multiples of 1000

    Returns: string
```

Because this is so incredibly helpful, you need to get into the practice of providing a docstring for every method you write.
