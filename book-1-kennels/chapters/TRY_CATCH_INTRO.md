# Basic Exception Handling

Because Python is a dynamically typed language, you need to carefully consider how to get the type of a variable and make no assumptions in your code.

Let's look at some basic code and see what harmful side-effects can happen.

```python
class BankAccount():

  def __init__(self):
    self.balance = 0

  def add_money(self, amount):
    """Add money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will increase
    """
    self.balance += amount

  def withdraw_money(self, amount):
    """Withdraw money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will decrease
    """
    self.balance -= amount
```

Given this class, a developer could easily write this code.

```python
my_account = BankAccount()
my_account.add_money('Gazillion dollars')
my_account.add_money(-55)
```

This will raise a `TypeError` exception because the logic for the `add_money()` tries to perform a mathematical calculation on the value that is stored in the `amount` argument. We passed in a string, so Python will yell at us.
There is no type coercion in Python. So, in JavaScript "2" + 2 will work, and give you "22", but not so in Python.

So we need to think about these kinds of issues when writing our code instead of assuming that the code that invokes this method will _always_ do the correct thing. We need implement exception handling so that a useful exception is raised to the invoking code.

Let's look at how to do that with `try...except` blocks.

```python
def add_money(self, amount):
    """Add money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will increase
    """
    try:
        if amount >= 1:
            self.balance += amount
            print("Your deposit was successful")
            return self.balance
        else:
            raise ArithmeticError("Amount needs to be a positive number")

    except TypeError:
        print('(Error): The add_money method requires a numeric value')
        raise
    except ArithmeticError as err:
        print(f"Your deposit was not successful. Error: {err}")
        raise
```

Now, if an incorrect type of value is passed, a human-friendly message is output to the console and the exception is re-raised up to the calling code.
