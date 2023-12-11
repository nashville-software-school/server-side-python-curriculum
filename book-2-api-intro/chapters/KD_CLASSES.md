# Classes for Creating Jewelry Objects

Now that you have built some classes in the Kennels project, you are going to practice building more for Kneel Diamonds. When defining classes for a project, the simplest way to start is to create a class for each table that you have in your ERD.

## Models Package

Just as you did for Kennels, create a models directory and make it a package by adding the init module.

Then create a module for each resource in your ERD. For example, you can start by creating a `metals.py` module in the `models` directory.

Inside each module, create a class to represent that resource. Remember that when defining a class, it should be Pascal-cased instead of Snake-cases.

Refer to the models that you wrote for Kennels to ensure that you define the correct parameters for the class init method, and that you assign each one as a property of `self` in the method.

```py
class Metal():
    """Class that defines the properties for a metal object"""

    # Write the __init__ method here
```

Follow this process for each database model needed for Kneel Diamonds. When you are done, you should have 4 modules in the `models` directory, and the class defined in each one should be imported into the `__init__.py` module.
