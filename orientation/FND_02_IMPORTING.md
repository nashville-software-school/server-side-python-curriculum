# Importing Modules

Importing other modules in Python is very similar to how to did it in Browserify or including dependencies in Angular. Instead of the `require()` function in JavaScript, you use `import`.

```
# In JavaScript
let $ = require('jquery');


# In Python
import http
```

Python will look in every directory that is defined in `sys.path` for a file, or executable, that matches the name in your import statement. If you ever want to see those locations, you can just run the python interpreter in the CLI and take a look.

```
python

Python 3.4.3 (default, Feb 20 2016, 13:01:44) 
[GCC 4.2.1 Compatible Apple LLVM 7.0.2 (clang-700.1.81)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path
['', '/Users/student/.pyenv/versions/3.4.3/lib/python34.zip', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4/lib-dynload', '/Users/student/.pyenv/versions/3.4.3/lib/python3.4/site-packages']

```

## Import Your Module

Python will also look in the immediate directory for any files matching what you want to import. After it's imported, your can call any method in that module. Just precede it with the module name.

```python
modulename.function_name(arguments)
```

Consider the [`humansizes.py`](humansizes.py) file you created. In the same directory, open the interpreter and import the file as a module.

```
python

Python 3.4.3 (default, Feb 20 2016, 13:01:44) 
[GCC 4.2.1 Compatible Apple LLVM 7.0.2 (clang-700.1.81)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import humansizes
>>> print(humansizes.approximate_size(80808080, True))
77.1 MiB
```

Remember the `__name__` property of a module that had a value of `__main__` when executed independently. Well, when you import that same module into another one, the `__name__` is the file name.

```
>>> print(humansizes.__name__)
humansizes
```

## Reading a Function's docstring

If you ever want to see the developer's documentation of a function, you can access the built-in `__doc__` property on the function.

```
>>> print(humansizes.approximate_size.__doc__)
Convert a file size to human-readable form.

    Keyword arguments:
    size -- file size in bytes
    a_kilobyte_is_1024_bytes -- if True (default), use multiples of 1024
                                if False, use multiples of 1000

    Returns: string

    

```

Because this is so incredibly helpful, you need to get into the practice of providing a docstring for every method you write.
