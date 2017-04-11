# Open - Closed Principle

#### Original explanation
> A satisfactory modular decomposition technique must satisfy one more requirement: 
> 
> It should yield modules that are both **open** and **closed**.
> 
> * A module will be said to be **open** if it is available for extension. For example, it should be possible to add fields to the data structures it contains, or new elements to the set of functions it performs.
> * A module will be said to be **closed** if is available for use by other modules. This assumes that the module has been given a well-defined, stable description (the interface in the sense of information hiding). In the case of a programming language module, a **closed** module is one that may be compiled and stored in a library, for others to use. In the case of a design or specification module, closing a module simply means having it approved by management, adding it to the project's official repository of accepted software items (often called the project baseline), and publishing its interface for the benefit of other module designers.

#### Modern explanation

> The open/closed principle states "software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification"; that is, such an entity can allow its behaviour to be extended without modifying its source code.

## What does this mean?

Imagine a system that is architected so that it could be infinitely extendable without having the modify a single line of code of the system. Every module could have its behavior extended, or completely overridden. New features could be added to the system without modifying the system.

Seem impossible?

Consider the tools that you use on a day-to-day basis: modern code editors.

Ever installed a plugin that provides the ability to do something in the editor that the base installation couldn't? Well, you just witnessed a very powerful implementation of the Open-Closed Principle. The base program is very rarely changed, and yet plugin developers can quickly provide extensions of the core system to fill the needs of different developers.

What's amazing about this kind of architecture is that the plugins have the ability to know about much of the architecture of the core system, and yet the core system has zero knowledge of the plugins.

![](./open-closed-viz.png)

## Basic Bank & Teller System

```py
import locale

class BankAccount():

  def __init__(self):
    self.balance = 0
    self.account = None

  def add_money(self, amount):
    """Add money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will increase
    """
    self.balance += float(amount)

  def withdraw_money(self, amount):
    """Withdraw money to a bank account

    Arguments:
      amount - A numerical value by which the bank account's balance will decrease
    """
    pass
    self.balance -= float(amount)

  def show_balance(self):
    """Show formatted balance

    Arguments:
      None
    """
    locale.setlocale( locale.LC_ALL, '' )
    return locale.currency(self.balance, grouping=True)
```

```py
import os
from bank import *


class Teller():
  """This class is the interface to a customer's bank acccount"""

  def __init__(self):
    self.account = BankAccount()

  def build_menu(self):
    """Construct the main menu items for the command line user interface"""

    # Clear the console first
    os.system('cls' if os.name == 'nt' else 'clear')

    # Print all the options
    print("1. Add money")
    print("2. Withdraw money")
    print("3. Show balance")
    print("4. Quit")

  def main_menu(self):
    """Show teller options"""

    # Build the menu
    self.build_menu()

    # Wait for user input
    choice = input(">> ")

    # Perform the appropriate actions corresponding to user choice
    if choice == "1":
      deposit = input("How much? ")
      self.account.add_money(deposit)

    if choice == "2":
      withdrawal = input("How much? ")
      self.account.withdraw_money(withdrawal)

    if choice == "3":
      print(self.account.show_balance())
      input()

    # If the user chose anything except Quit, show the menu again
    if choice != "4":
      self.main_menu()


if __name__ == "__main__":
  teller = Teller()
  teller.main_menu()
```

