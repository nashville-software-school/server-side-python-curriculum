# Conditionals

## Setup

First, open up your Terminal or Command Prompt.
Then, paste in this command: 

```sh
mkdir -p ~/Documents/python/orientation && cd $_
jupyter notebook
```

Create a _new_ notebook labelled `Chapter 2` using the `python3` option.

## What's a conditional?
Evaluating logic given certain conditions.

Basically a `CASE WHEN ...` statement in SQL.
The general syntax goes like this: 
```python
if <condition 1>:
    # do something for condition 1!

elif <condition 2>:
    # do something for condition 2!

else:
    # do something as a catch all!
```

There are a few important pieces to note here.
1. Notice the **colon** at the end of the conditional lines. 
The code will NOT run if these aren't present!
This is python's way of knowing when you are about to _indent_.
2. As mentioned.. 
Take a look at the indent. 
This is 4 _spaces_. 
Do not confuse spaces with tabs!
You want to indent after your colon to represent a new block of code.

Let's take a look a more practical example. 

```python
name = 'FooBar'

if name == 'Foo':
    print('First condition met')

elif name == 'Bar':
    print('Second condition met')

else:
    print('No idea what the name could be!')
```

Here is a more complex example.
```python
name = 'FooBar'

if name == 'Foo' or name == 'Bar':
    name = name.lower()

elif len(name) > 3:
    name = name.capitalize()

else:
    name = name.upper()

print(name)    
```

### Exercise 1

Given the following: 
```python
number = 5
```

Write a conditional that meets the following criteria:
* When number is less than 3, print `low`
* When number is between 3 and 20, print `mid`
* Wen number is greater than 20, print `high`


### Exercise 2

Given the following: 
```python
number = 5
prime = True
```

Write a conditional that meets the following criteria:
* For when prime is True
    * When number is less than 3, print `low`
    * When number is between 3 and 20, print `mid`
    * Wen number is greater than 20, print `high`
* When prime is False
    * print : 'Not a prime number'
