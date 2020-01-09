# Not Hello, World

## Setup

Here's your very first Python code module. Go ahead and create a new directory for storing your Python code and create a file named `humansizes.py`.

```sh
mkdir ~/workspace/python/intro && cd $_
touch humansizes.py
code .
```

Next, copy pasta the code in the [humansizes.py](assets/humansizes.py) into yours. The first thing you might notice is the lack of curly braces defining the beginning and ending of a block of logic. In Python, indentation is king. Whitespace matters, unlike in JavaScript.

## Evaluating a module of Code

If you don't already have it open, click the orange demon-thingy icon in the upper right of your VSCode screen to launch an AREPL session. This will allow you to see the results of your `print()` statements.

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

## Python Modules

Importing other modules in Python is very similar to how you did it in Browserify and React, using the `import` statement.

```py
import http
import sys
import student
import instructor
```

But compared to how you've written it before, the syntax looks a little inside-out when importing a specific part of a module. With JavaScript modules, you specified what you want to import and from where.

```js
// JavaScript importing
import factory from "./foodFactory"
```

In Python, it's kinda backwards.

```py
# Python importing
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
