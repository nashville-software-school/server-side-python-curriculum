# Python Functions

Python functions are the same as JavaScript functions, but the syntax is different and white space matters.

Let's say that again: **WHITE SPACE MATTERS**.

Remember how we hounded you about proper formatting in the client side course? Now, you have to do it for real or your code won't work. When writing a function You must indent the contents of the function.

Look at how the same function is written in the two different syntaxes.

```js
// A JavaScript function
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

```py
# A Python function
def create_person(first_name, last_name, age, occupation):
    return {
        "first_name": first_name,
        "last_name": last_name,
        "age": age,
        "occupation": occupation,
    }

melissa = create_person("Melissa", "Bell", 25, "Software Developer")
```

## Practice: Coins to Cash

```sh
mkdir -p ~/workspace/python/coins-to-cash && cd $_
touch coins_to_cash.py
code .
```

Create a function that will take all your coins and convert it to the cash amount.

```python
def calculate_dollars(pennies, dimes, quarters, nickels):
    # The function should look at each parameter (pennies, nickels,
    # dimes and quarters) and perform the appropriate math on
    # the integer value to determine how much money you have
    # in dollars.

dollar_amount = calculate_dollars(pennies=342, nickels=9, dimes=32, quarters=4)

print(f'${dollar_amount}')
```

The output would be `$8.07` when the function is executed with those arguments.

## Cash to Coins

```sh
mkdir -p ~/workspace/python/cash-to-coins && cd $_
touch cash_to_coins.py
code .
```

Now do the reverse.

Write a **calculate_coins** function that converts a dollar amount into the coins that make up that dollar amount. The final result is a dictionary with the correct number of quarters, dimes, nickels, and pennies.

```py
dollar_amount = 8.69

# Python magic here

coins = calculate_coins(dollar_amount)
print(coins)

"""
This is what should be returned from the function for that dollar amount

{
    "pennies": 4,
    "nickels": 1,
    "dimes": 1,
    "quarters": 34
}
"""
```
