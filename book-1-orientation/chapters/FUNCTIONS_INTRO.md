# Python Functions

Python functions are the same as JavaScript functions, but the syntax is different and white space matters.

Let's say that again: **WHITE SPACE MATTERS**.

Remember how we hounded you about proper formatting in the client side course? Now, you have to do it for real or your code won't work. When writing a function You must indent the contents of the function.

Look at how the same function is written in the two different syntaxes.

```js
const createPerson = (firstName, lastName, age, occupation) => {
    return {
        firstName,
        lastName,
        age,
        occupation
    }
}

melissa = createPerson("Melissa", "Bell", 25, "Software Developer")
```

```python
# Function and variable names are snake case instead of camel case
def create_person(first_name, last_name, age, occupation):
    return {
        "first_name": first_name,
        "last_name": last_name,
        "age": age,
        "occupation": occupation,
    }

melissa = create_person("Melissa", "Bell", 25, "Software Developer")
```

## Practice: Activities for Kids

Define four Python functions named `run`, `swing`, `slide`, and `hide_and_seek`. Each function should take a child's name as an argument. Each function should print that the child performed the activity.

For example, `Jay ran like a fool!` or `Chantelle slid down the slide!`.

The following lists of children should be iterated, and the names sent to the appropriate functions.

```py
running_kids = ["Pam", "Sam", "Andrea", "Will"]
swinging_kids = ["Marybeth", "Jenna", "Kevin", "Courtney"]
sliding_kids = ["Mike", "Jack", "Jennifer", "Earl"]
hiding_kids = ["Henry", "Heather", "Hayley", "Hugh"]
```

## Practice: ChickenMonkey

Write a program that prints the numbers from 1 to 100. You can use Python's [range()](https://www.pythoncentral.io/pythons-range-function-explained/) to quickly make a list of numbers.

* For multiples of five (5, 10, 15, etc.) print "Chicken" instead of the number
* For the multiples of seven (7, 14, 21, etc.) print "Monkey".
* For numbers which are multiples of both five and seven print "ChickenMonkey".

To determine if a number can be evenly divided by 5 or 7, use the Python [modulo](https://docs.python.org/3.7/reference/expressions.html#binary-arithmetic-operations) operator.

## Coins to Cash

```sh
mkdir -p ~/workspace/python/coins-to-cash && cd $_
touch coinsToCash.py
code .
```

Create a function called `calc_dollars`. In the function body, define a dictionary and store it in a variable named `piggyBank`. The dictionary should have the following keys defined.

* quarters
* nickels
* dimes
* pennies

For each coin type, give yourself as many as you like.

```js
piggyBank = {
    "pennies": 342,
    "nickels": 9,
    "dimes": 32
}
```

Once you have given yourself a large stash of coins in your piggybank, look at each key and perform the appropriate math on the integer value to determine how much money you have in dollars. Store that value in a variable named `dollarAmount` and print it.

Given the coins shown above, the output would be `7.07` when you call calc_dollars()

## Cash to Coins

```sh
mkdir -p ~/workspace/python/cash-to-coins && cd $_
touch cashToCoins.py
code .
```

Now do the reverse. Convert the dollar amount into the coins that make up that dollar amount. The final result is an object with the correct number of quarters, dimes, nickels, and pennies.

```py
dollarAmount = 8.69

piggyBank = {
    "pennies": 0,
    "nickels": 0,
    "dimes": 0,
    "quarters": 0
}

# Your magic Python code here
```

That should produce the following output.

```py
>>> print(piggyBank)
{ 'quarters': 34, 'nickels': 1, 'dimes': 1, 'pennies': 4 }
```
