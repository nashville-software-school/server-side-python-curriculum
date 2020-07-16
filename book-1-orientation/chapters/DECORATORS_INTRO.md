# Python Decorators

## Why Are You Learning This?

In the first three months at NSS, you learned the JavaScript language. One of the features of the langugage that you used quite a bit _(even if you still don't really get it yet)_ is the concept of functions being **first-class objects**. You can pass functions as parameters to other functions just like strings or numbers.

Imagine that you want to build an application that tests the ability of a person to read text that is printed normally, but also if the text is printed backwards so that you can measure their reading comprehension skills.

First you would define several functions that return random sentences.

```js
const letterPress = () => "Adaptogen tote bag drinking vinegar, letterpress pabst locavore migas hella"

const taxidermy = () => "Taxidermy health goth locavore, pickled post-ironic pork belly kale chips tofu PBR&B bicycle rights"

const mustache = () => "Umami hexagon stumptown enamel pin, mustache echo park readymade celiac"

const lumberSexual = () => "Jean shorts lumbersexual stumptown tumeric everyday carry readymade"

console.log(letterPress())
console.log(taxidermy())
console.log(mustache())
console.log(lumberSexual())
```

You will occasionally switch which one of these functions will have the characters reversed. You certainly don't want to manually modify this code each time you want to change which ones are normal and which ones are reversed.

You will create a function to reverse any string.

```js
const reversal = sentenceFunc => {
    const originalSentence = sentenceFunc()
    return originalSentence.split("").reverse().join("")
}
```

Then you can change your console output by passing the sentence functions to reversal.

```js
console.log(reversal(letterPress))
console.log(taxidermy())
console.log(reversal(mustache))
console.log(lumberSexual())
```

In this scenario, the `reversal()` function is considered a decorator because it consumes the output of the original method and then outputs something different.

## Python Reversal Decorator

As you learn the Python language and the Django application framework, you will encounter decorators. Decorators are a specific syntax to do exactly what was done in the example above - send functions to other functions to extend their capabilities. Here's how the above JavaScript code would be done in Python.

```py
def reversal(sentence_func):
    def reversed_sentence(*args, **kwargs):
        original_sentence = sentence_func(*args, **kwargs)
        return f"Reversed: {''.join(reversed(original_sentence))}"
    return reversed_sentence


@reversal
def letterPress():
    return "Adaptogen tote bag drinking vinegar, letterpress pabst locavore migas hella"


def taxidermy():
    return "Taxidermy health goth locavore, pickled post-ironic pork belly kale chips tofu PBR&B bicycle rights"


@reversal
def mustache():
    return "Umami hexagon stumptown enamel pin, mustache echo park readymade celiac"


def lumberSexual():
    return "Jean shorts lumbersexual stumptown tumeric everyday carry readymade"


print(letterPress())
print(taxidermy())
print(mustache())
print(lumberSexual())
```

##### Output

```sh
Reversed: alleh sagim erovacol tsbap sserprettel ,rageniv gniknird gab etot negotpadA
Taxidermy health goth locavore, pickled post-ironic pork belly kale chips tofu PBR&B bicycle rights
Reversed: cailec edamydaer krap ohce ehcatsum ,nip lemane nwotpmuts nogaxeh imamU
Jean shorts lumbersexual stumptown tumeric everyday carry readymade
```

## The Basics

1. Read the "[A guide to Python's function decorators](https://www.thecodeship.com/patterns/guide-to-python-function-decorators/)" article and do all of the exercises in it to learn the basic vocabulary and syntax of what a decorator is.
1. Read the "[Primer on Python Decorators](https://realpython.com/primer-on-python-decorators/)" article and do all of the exercises in it to explore decorator in greater depth.

## Practice: Family Report with Decorators

You need to write functions to represent tasks that members of a family need to perform on a regular basis.

```py
def laundry():
    return "The dirty laundry was cleaned"

def garbage():
    return "The garbage was taken out"

def dust():
    return "The house was dusted"

def groom():
    return "The dog was brushed"
```

Write a decorator function named `@kids` that, when placed above a function, will modify the return value of that function to have "by the kids" appended to the end. For example, if the decorator is above the `garbage()` function, when you invoke the method, it should return "The garbage was taken out by the kids"

```py
@kids
def garbage():
    return "The garbage was taken out"

result = garbage()
print(result)  # "The garbage was taken out by the kids"
```

Now write two more decorator functions named `@dad` and `@mom` and place them above the functions that you want to assign to the parents. The output should be appended with "by Dad" or "by Mom".

## Practice: Michael's Mortuary

Michael Tambornino's father opened up the Juniper Hill Mortuary back in 1959 and has served their community faithfully since. It's a trusted business that people in the entire town use to make sure that a family member's death is handled with care and compassion.

Michael took over the operation of the business in 2017 and realized that everything was still done non-digitally. All the ledgers, receipts, billing, and funeral records were hand-written and stored in massive filing cabinets in the basement. Michael knew that one fire or flood would wipe out the entire business. In college, he took a couple accounting classes and an introduction to computing class and new that modern technology could make the operation of the business much easier and also have all the critical financial information backed up in case of catastrophe.

He has hired you on a contract basis to start building applications that will allow him, and his staff, to enter information digitally on their computers or iPads any time they like.

> Michael tells you, "Now that all of our current employees, customers, and deceased people we have processed are in the database, I want you to create some basic web pages that list all of the information for each type of person."
>
> You ask him some basic questions about which data should appear, and he replies "To start off with, I'd just to see all of it. If it's too much, then we can start removing some of the information from the lists".
>
> You nod and diligently take notes on his requirements.
>
> Michael's eyebrows lift suddenly as he comes to some sort of realization. "I also want the lists order by last name and then first name. All of our current records are sorted that way, so I'd like to start with the same system on the web pages."

As you start building the system, you come up with the idea to start all of your SQL queries in a single class. Then you know you have one place where they all live and never have to worry about duplicating code throughout your system.

You make sure that any time you are listing people's names, that you sort by last name then first name.

```py
class Queries:

    def customers(self):
        return """SELECT * FROM Customer
            ORDER BY last_name ASC, first_name ASC
        """

    def coffins(self):
        return "SELECT * FROM Product"

    def employees(self):
        return """SELECT * FROM Employee
            ORDER BY last_name ASC, first_name ASC
        """

    def gravestones(self):
        return "SELECT * FROM GraveStones"

    def deceased(self):
        return """SELECT * FROM Deceased
            ORDER BY last_name ASC, first_name ASC
        """

    def obelisks(self):
        return "SELECT * FROM Obelisk"

    def vendors(self):
        return """SELECT * FROM Vendor
            ORDER BY last_name ASC, first_name ASC
        """
```

After you get done building this initial class, you realize that the `ORDER BY` clause is the exact same all of the SQL statements. You realize that if you ever need to store data about any different kind of people, you will need the same `ORDER BY` clause for each one.

This is a perfect opportunity to implement a decorator, which will ensure that each query is always written the same way. Thus, reducing the possibility of errors in the future.

Your job is to write a decorator function named `sort_by_name` that you can use on `vendors`, `employees`, `customers`, and `deceased` so that the `ORDER BY last_name ASC, first_name ASC` clause is added to them.

```py
class Queries:

    @sort_by_name
    def customers(self):
        return "SELECT * FROM Customer"

    def coffins(self):
        return "SELECT * FROM Coffin"

    @sort_by_name
    def employees(self):
        return "SELECT * FROM Employee"

    def gravestones(self):
        return "SELECT * FROM GraveStones"

    @sort_by_name
    def deceased(self):
        return "SELECT * FROM Deceased"

    def obelisks(self):
        return "SELECT * FROM Obelisk"

    @sort_by_name
    def vendors(self):
        return "SELECT * FROM Vendor"
```

Here's some sample output for a properly implemented decorator.

```py
queries = Queries()

print(queries.customers())
print(queries.coffins())
print(queries.employees())

# Output
SELECT * FROM Customer ORDER BY last_name ASC, first_name ASC
SELECT * FROM Coffin
SELECT * FROM Employee ORDER BY last_name ASC, first_name ASC