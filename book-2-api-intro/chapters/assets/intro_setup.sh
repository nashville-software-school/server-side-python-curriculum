#!/bin/bash
set -u

mkdir -p ~/workspace/python/critters/animals
mkdir -p ~/workspace/python/critters/habitats
touch ~/workspace/python/critters/animals/__init__.py
touch ~/workspace/python/critters/animals/ostrich.py
touch ~/workspace/python/critters/main.py
cd ~/workspace/python/critters

echo '# Importing a built-in module of code from the Python Standard Library
import os

# Importing a custom type, or class, from the animals package
from animals import Ostrich


# Python syntax for a function
def clear_screen():
    os.system("cls" if os.name == "nt" else "clear")


# Another function.
def ask_answer():
    """This is a docstring function in Python. It provides
    documentation for the purpose and context of the function.
    The line of code above that starts with `def` is now you
    define a function in Python.
    """

    # Invoke another function defined ☝🏻 there
    clear_screen()

    # Display some text to the terminal. This is your new console.log()
    print("What is the answer?")

    # Ask the user to type something. This is your new input box for the terminal.
    choice = input("> ")

    try:
        # Yup, it is an `if..else` statement in Python. Not that different.
        if int(choice) == 88:  # int() converts a string to an integer
            clear_screen()
            print("Welcome to Python 🐍 You just read your first module of code!!")

            input("Correct! Press any key to see an ostrich!")

            clear_screen()
            print("""
           -O    /O
             \ __|/
              (_ )
                \\
               _/

            """)
            # Create a new object instance based on the Ostrich class
            oscar = Ostrich()
            print(oscar)
        else:
            input("Incorrect. Press any key to continue...")
            ask_answer()
    except ValueError:
        input("Try a number instead. Press any key to continue...")
        ask_answer()


ask_answer()

' > ./main.py

echo 'from .ostrich import Ostrich' > ./animals/__init__.py

echo 'from uuid import uuid1

class Ostrich(object):

    def __init__(self) -> None:
        self.id = uuid1()

    def __repr__(self) -> str:
        return f"Hi, I am ostrich {self.id}"
' > ./animals/ostrich.py

curl https://raw.githubusercontent.com/nashville-software-school/client-side-mastery/cohort-42/book-4-nashville-kennels/chapters/images/logo.png > logo.png

