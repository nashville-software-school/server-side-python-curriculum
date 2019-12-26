# Python Functions

A function is a block of organized, reusable code that is used to perform a single, related action. 
Functions provide better modularity for your application and a high degree of code reusing.

Remember saying `print('Print!')`?? 
`print` is a function that we have been using up until now.

You can define functions to provide the required functionality. Here are simple rules to define a function in Python.

```python
def functionname( parameters ):
   "function_docstring"
   function_suite
   return [expression]
```

* Function blocks begin with the keyword `def` followed by the function name and parentheses ( `( )` ).
* Any input parameters or `arguments` should be placed within these parentheses. 
You can also define parameters inside these parentheses.
* The first statement of a function can be an optional statement - the documentation string of the function or `docstring`.
* The code block within every function starts with a colon (`:`) and is _indented_ (whitespace matters!!).
* The statement return `[expression]` exits a function, optionally passing back an expression to the caller. 
A return statement with no arguments is the same as return `None`.

Let's say that again: **WHITE SPACE MATTERS**.

If you do not use appropriate whitespace, your code won't work. 
When writing a function You must indent the contents of the function (4 spaces).

Let's look at a function that will create a person.

```python
# Function and variable names are snake case. Look it up!
def create_person(first_name, last_name, age, occupation):
    """Return a dictionary that represents a person."""
    return {
        "first_name": first_name,
        "last_name": last_name,
        "age": age,
        "occupation": occupation,
    }

melissa = create_person("Melissa", "Bell", 25, "Data Analyst")
```

* Like the above example, `create_person` starts with the `def` keyword.
* The name of the function it `create_person`.
Note that it is all _lowercase_, and words are separated by an _underscore_.
* `create_person` accepts 4 arguments as input: `first_name, last_name, age, occupation`.
The trick here is to understand that these arguments haven't been defined yet. 
They are simply placeholders, or variables!
* Note the colon at the end of the first line! 
This is important.
* The next line is the docstring. 
This helps describe the function at a high level.
Note the indent!
* Lastly, our `logic` or `[expression]`.
This is a simple function that does only one thing.. 
Returns a dictionary with the values mapped to specific keys!

Let's look at how our function is being called. 
```python
melissa = create_person("Melissa", "Bell", 25, "Data Analyst")
```
Regarding function arguments, order matters. 
The function defined 4 arguments (`first_name, last_name, age, occupation`) that must be provided when called. 
So, mapping it out..
* first_name: "Mellisa"
* last_name: "Bell"
* age: 25
* occupation: "Data Analyst"

## Practice: Activities for Kids

Define four Python functions named `run`, `swing`, `slide`, and `hide_and_seek`. 
Each function should take a child's name as an argument. 
Each function should print that the child performed the activity.
This should be done in a brand new notebook.

For example, `Jay ran like a fool!` or `Chantelle slid down the slide!`.

The following lists of children should be iterated, and the names sent to the appropriate functions.

```py
running_kids = ["Pam", "Sam", "Andrea", "Will"]
swinging_kids = ["Marybeth", "Jenna", "Kevin", "Courtney"]
sliding_kids = ["Mike", "Jack", "Jennifer", "Earl"]
hiding_kids = ["Henry", "Heather", "Hayley", "Hugh"]
```

## Practice: ChickenMonkey

Write a program that prints the numbers from 1 to 100. 
This should be in a brand new notebook.
You can use Python's [range()](https://www.pythoncentral.io/pythons-range-function-explained/) to quickly make a list of numbers.

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

Create a function called `calc_dollars`. 
This should be in a new notebook.
In the function body, define a dictionary and store it in a variable named `piggyBank`. 
The dictionary should have the following keys defined.

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

Once you have given yourself a large stash of coins in your piggybank, look at each key and perform the appropriate math on the integer value to determine how much money you have in dollars. 
Store that value in a variable named `dollarAmount` and print it.

Given the coins shown above, the output would be `7.07` when you call calc_dollars()

## Cash to Coins

```sh
mkdir -p ~/workspace/python/cash-to-coins && cd $_
touch cashToCoins.py
code .
```

Now do the reverse.
Convert the dollar amount into the coins that make up that dollar amount. 
The final result is an object with the correct number of quarters, dimes, nickels, and pennies.

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
