# Exception Handling with `try..except`

## Explanation
In Python, exceptions are errors that occur during the execution of a program. When an exception is raised, it disrupts the normal flow of the program and can cause it to crash. To prevent this, we can use `try..except` blocks to catch and handle exceptions gracefully.

The `try` block contains the code that might raise an exception, and the `except` block contains the code that handles the exception if it occurs. This allows the program to continue running even if an error is encountered.

## Syntax
The basic syntax of a `try..except` block is as follows:

```python
try:
    # Code that might raise an exception
    pass
except SomeException as e:
    # Code to handle the exception
    pass
```

## Handling a `TypeError`

Let's look at an example of handling a `TypeError`. A `TypeError` occurs when an operation is performed on an inappropriate type of object. For example, trying to add a number and a string will raise a `TypeError`.

Create a Python module named `exceptions.py` and run the following code. Note the exception that gets raised.

```python
def add_numbers(a, b):
    result = a + b
    print(f"The result is: {result}")

# Example usage
add_numbers(5, "10")
```

To handle that exception, and produce more useful output, you wrap it in a **try** block.

```python
def add_numbers(a, b):
    try:
        result = a + b
        print(f"The result is: {result}")
    except TypeError as e:
        print(f"Please provide two integers as arguments when invoking this function.")

# Example usage
add_numbers(5, "10")
```

In this example, the `add_numbers` function tries to add `a` and `b`. If a `TypeError` occurs (e.g., adding an integer and a string), it is caught in the `except` block, and an error message is printed.

## Exercise: Handling a `KeyError`

### Instructions

A `KeyError` occurs when you try to access a dictionary key that does not exist. In this exercise, you'll write a function that tries to access a key in a dictionary and handle the `KeyError` if the key is not found.

### Starter Code

Run the following code to see that it generates a `KeyError`. Your job is to wrap the offending code in a `try..except` block to handle that exception and print a useful message to the console.

```python
my_dict = {"name": "Alice", "age": 30, "city": "New York"}

def get_value(dictionary, key):
     value = dictionary[key]
     print(f"The value for '{key}' is: {value}")

# Example usage
get_value(my_dict, "name")
get_value(my_dict, "occupation")
```

### Expected Output
The function should print the value for the key if it exists in the dictionary. If the key does not exist, it should print an error message.

```python
The value for 'name' is: Alice
KeyError: The key 'occupation' was not found in the dictionary.
```

## Exercise: Handling a `ZeroDivisionError`

### Instructions

A `ZeroDivisionError` occurs when you try to divide a number by zero. In this exercise, you'll write a function that attempts to divide two numbers and handle the `ZeroDivisionError` if the denominator is zero.

### Starter Code

Place the following code in a new module named `shopping_cart.py`. The following code generates a `ZeroDivisionError`. Your task is to have the function return 0 if there are no items in the cart by implementing a `try..except` block.

```python
shopping_cart_items = []

def average_price(cart_items):
    average = 0

    for item in cart_items:
      average += item.price

    average = average / len(cart_items)

    return average

average_price_of_cart_items = average_price(shopping_cart_items)

print(f"Your average cart item price is {shopping_cart_items} dollars")
```

Go back to the [main project list](../README.md) and start on the Critters &amp; Croquettes project.