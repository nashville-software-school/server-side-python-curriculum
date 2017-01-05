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
```

This will raise a `TypeError` exception because the logic for the `add_money()` tries to perform a mathematical calculation on the value that is stored in the `amount` argument. We passed in a string, so Python will yell at us.

So we need to think about these kids of issues when writing our code instead of assuming the the code that invokes this method will *always* do the correct thing. We need implement exception handling so that a useful exception is raised to the invoking code.

Let's look at how to do that with `try...except` blocks.

```python
  def add_money(self, amount):
    """Add money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will increase
    """
    try:
      self.balance += amount
      return self.balance
    except TypeError:
      print('(Error): The add_money method requies a numeric value')
      raise
```

Now, if an incorrect type of value is passed, a human-friendly message is output to the console and the exception is re-raised up to the calling code.







