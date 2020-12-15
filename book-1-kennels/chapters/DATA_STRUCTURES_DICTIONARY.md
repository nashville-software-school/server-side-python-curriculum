# Python Dictionary

## Overview

Dictionaries are the new Object from JavaScript. They are key/value pairs just like objects, but creating and accessing the key/value pairs can only be done with square-bracket notation.

You can create a dictionary in two ways.

```py
# Dictionaries (unordered, mutable, does NOT allow duplicates & indexed w/ key value pairs)

# Create an empty dictionary
animal = dict()
# Add k/v pairs
animal["name"] = "Kevin"
animal["breed"] = "Bulldog"
animal["age"] = 5

# Create the dictionary with k/v pairs and assign to variable
animal = {
    "name": "Kevin",
    "breed": "Bulldog",
    "age": 5
}
```

Dictionaries are iterable.

```py
for (key, value) in animal.items():
    print(f"{key}: {value}")

# Output
name: Kevin
breed: Bulldog
age: 5
```

## Setup

```sh
mkdir -p ~/workspace/python/dictionaries && cd $_
touch dictionaryOfWords.py
```

## References

* [Python dictionaries](https://docs.python.org/3.6/tutorial/datastructures.html#dictionaries)
* [Learn Python - Dictionaries](https://www.learnpython.org/en/Dictionaries)
* [Introducing Dictionaries](http://www.diveintopython.net/native_data_types/index.html#odbchelper.dict)

## Practice: Dictionary of Words

You are going to build a Python Dictionary to represent an actual dictionary. Each key/value pair within the Dictionary will contain a single word as the key, and a definition as the value. Below is some starter code. You need to add a few more words and definitions to the dictionary.

After you have added them, use square bracket notation to output the definition of two of the words to the console.

Lastly, use the `for in` loop to iterate over the KeyValuePairs and display the entire dictionary to the console.

```py
"""
Create a dictionary with key value pairs to
represent words (key) and its definition (value)
"""
word_definitions = dict()

"""
Add several more words and their definitions
   Example: word_definitions["Awesome"] = "The feeling of students when they are learning Python"
"""

"""
Use square bracket lookup to get the definition of two
words and output them to the console with `print()`
"""


"""
Loop over the dictionary to get the following output:
    The definition of [WORD] is [DEFINITION]
    The definition of [WORD] is [DEFINITION]
    The definition of [WORD] is [DEFINITION]
"""
```

## Practice: English Idioms

Create a new Python file and paste the following code into it. At the end write a `for in` loop to produce the output below.

```py
idioms = {
    "Penny": ["A", "penny", "for", "your", "thoughts"],
    "Injury": ["Add", "insult", "to", "injury"],
    "Moon": ["Once", "in", "a", "blue", "moon"],
    "Grape": ["I", "heard", "it", "through", "the", "grapevine"],
    "Murder": ["Kill", "two", "birds", "with", "one", "stone"],
    "Limbs": ["It", "costs", "an", "arm", "and", "a", "leg"],
    "Grain": ["Take", "what", "someone", "says", "with", "a", "grain", "of", "salt"],
    "Fences": ["I'm", "on", "the", "fence", "about", "it"],
    "Sheep": ["Pulled", "the", "wool", "over", "his", "eyes"],
    "Lucifer": ["Speak", "of", "the", "devil"],
}
```

> Make sure you [join](https://www.tutorialspoint.com/python/string_join.htm) the strings

#### Output

```markdown
Penny: A penny for your thoughts
Injury: Add insult to injury
Moon: Once in a blue moon
Grape: I heard it through the grapevine
Murder: Kill two birds with one stone
Limbs: It costs an arm and a leg
Grain: Take what someone says with a grain of salt
Fences: I'm on the fence about it
Sheep: Pulled the wool over his eyes
Lucifer: Speak of the devil
```

## Challenge: The Family Dictionary

### Setup

```
mkdir -p ~/workspace/python/exercises/family_dictionary && cd $_
touch family_dict.py
```

### Instructions

1. Define a dictionary that contains information about several members of your family. Use the following example as a template.
    ```py
    my_family = {
        "sister": {
            "name": "Krista",
            "age": 42
        },
        "mother": {
            "name": "Cathie",
            "age": 70
        }
    }
    ```
2. Using a dictionary comprehension, produce output that looks like the following example.
    ```haml
    Krista is my sister and is 42 years old
    ```

    > **Helpful hint:** To convert an integer into a string in Python, it's `str(integer_value)`



## Advanced Challenge: Stock Portfolio

A block of publicly traded stock has a variety of attributes. Let's look at a few of them. A stock has a ticker symbol and a company name. Create a simple dictionary with ticker symbols and company names.

### Setup

```
mkdir -p ~/workspace/python/exercises/stocksChallenge && cd $_
touch stocks.py
```

##### Example

```py
stockDict = {
    "GM": "General Motors",
    "CAT":"Caterpillar",
    "EK":"Eastman Kodak"
}
```

Create a simple list of blocks of stock. Make them tuples with ticker symbols, number of shares, dates and price.

##### Example

```py
purchases = [
    ( 'GE', 100, '10-sep-2001', 48 ),
    ( 'CAT', 100, '1-apr-1999', 24 ),
    ( 'GE', 200, '1-jul-1998', 56 )
]
```

Create a purchase history report that computes the full purchase price (shares times dollars) for each block of stock and uses the `stockDict` to look up the full company name. This is the basic relational database join algorithm between two tables.

Example output for one block:
`I purchased General Electric stock for $4800`

Create a second purchase summary that which accumulates total investment by ticker symbol. In the above sample data, there are two blocks of GE. These can easily be combined by creating a dict where the key is the ticker and the value is the list of blocks purchased. The program makes one pass through the data to create the dict. A pass through the dict can then create a report showing each ticker symbol and all blocks of stock.

Example output:
```haml
------ GE ------
100 shares at 48 dollars each on 01-jul-1998
200 shares at 56 dollars each on 10-sep-2001

Total value of stock in portfolio: $16000
```
