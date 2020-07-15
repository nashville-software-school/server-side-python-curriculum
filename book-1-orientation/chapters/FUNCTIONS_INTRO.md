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
# Passing a Variable Number of Arguments to a Function

In Python, we can pass a varying number of arguments to to a function. You can use either `*args` or `**kwargs`.

## Non Keyword Arguments

```python
def add(*list_of_numbers):
    sum = 0
    
    for number in list_of_numbers:
        sum = sum + number

    print("Sum:",sum)

add(3,5)
add(4,5,6,7)
add(1,2,3,5,6)
```

Here we have a function that is responsible for adding together all the numbers. Since there could be a varying amount of numbers, we use a non keyword argument (indicated by the * before the argument name) to specify that the number of arguments will vary.


## Keyword Arguments

```python
def make_family(name, **member):
    family_stuff = member.items()
    family_str = f"We are the {name} family. "
    for title, person in family_stuff:
        family_str += f"The {title} is {person}. "
    return family_str
```
Now we can make families of any size, and have flexibility to have those family members have whatever role we want

```py
the_shepherds = make_family("Shepherd", mom="Anne", dad="Joe", dog="Murph")
the_parkers = make_family("Parker", aunt="May", nephew="Peter")
print(the_shepherds)
print(the_parkers)
```

While we are can still pass a variable number of arguments, the arguments now have a keyword associated with it. In other words, you get to name the arguments that you pass to the function (a dictionary with key value pairs).

## Let's put everything together!

```python
def calculate_average(subject, *test_scores, **student_details):
    # print("Type & value of subject: ", type(subject), subject)
    # print("Type & value of test_scores: ", type(test_scores), test_scores)
    # print("Type & value of the student_details: ", type(student_details), student_details)

    if subject == "English":
        average_score = 49
    else:
        average_score = sum(test_scores)/len(test_scores)
    
    print(f"{student_details['last_name']}, {student_details['first_name']} got an average score of {average_score} in {subject}.")


calculate_average("Math", 75, 64, 35, first_name="Bryan", last_name="Nilsen")
```

## Practice: ChickenMonkey

Write a program that prints the numbers from 1 to 100. You can use Python's [range()](https://www.pythoncentral.io/pythons-range-function-explained/) to quickly make a list of numbers.

* For multiples of five (5, 10, 15, etc.) print "Chicken" instead of the number.
* For the multiples of seven (7, 14, 21, etc.) print "Monkey".
* For numbers which are multiples of both five and seven print "ChickenMonkey".

To determine if a number can be evenly divided by 5 or 7, use the Python [modulo](https://docs.python.org/3.7/reference/expressions.html#binary-arithmetic-operations) operator.

## Practice: Activities for Kids

Define four Python functions named `run`, `swing`, `slide`, and `hide_and_seek`. Each function should take varying number of children's names as the argument.

For example, the `run` function would be defined as follows:

```python
def run(*kids):
    # Loop through all the kids and print that the child performed the activity.

run("Joe", "Jenna")
# Output: 
# "Joe ran like a fool!"
# "Jenna ran like a fool!"
```

Do the same for the following children:

- Running kids: Pam, Sam, Andrea, Will
- Swinging kids: Marybeth, Ariel, Kevin, Courtney
- Sliding kids: Mike, Jack, Jennifer, Earl
- Hiding kids: Henry, Heather, Hayley, Hugh

## Coins to Cash

```sh
mkdir -p ~/workspace/python/coins-to-cash && cd $_
touch coinsToCash.py
code .
```

Create a function that will take all your coins and convert it to the cash amount.

```python
def calc_dollars(**coins):
    # The function should look at each key (pennies, nickels, dimes and quarters) and perform the appropriate math on the integer value to determine how much money you have in dollars. Store that value in a variable named `dollarAmount` and print it.

calc_dollars(pennies= 342, nickels=9, dimes=32, quarters=4)
```

The output would be `8.07` when the function is executed with those arguments.

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
