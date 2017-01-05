# Bangazon LLC Coding Standards

We will be following the [Python Community's coding guidelines](https://www.python.org/dev/peps/pep-0008/). Here are the big tickets items. Please read the style guide for more information.

1. Variable names are all lower case, with words seperated by underscores

    ```
    ThisIsBadPractice = False;
    this_is_good_practice = True;
    ```
2. All classes and methods will be documented with docstrings.
3. Four **spaces** for indentation.
4. Surround top-level function and class definitions with two blank lines. Method definitions inside a class are surrounded by a single blank line.
    ```
    import random


    def Bar():
        """Top level function"""


    class Foo:
        """Sample Foo class that does nothing"""

        def __init__(self):
            """Constructor function for Foo class"""
            bar = False
    ```
5. Import statements on seperate lines.

