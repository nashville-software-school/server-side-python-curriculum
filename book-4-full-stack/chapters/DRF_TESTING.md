# Automated Testing

## Overview

How do you know your code does what you think it does?

_You Test It!_

There are two basic approaches to testing.

### Manual Testing

You or _**someone else**_ uses the application and verify that it does what it's supposed to do. Usually a QA person will have a giant checklist of features to test and they will click, scroll and type into your app to make sure each feature works.

### Automated Testing

It's true that a human _could_ open a web browser or Postman and manually perform all the steps necessary to test all parts of a web application, but - like with many things - a computer can do it faster, with fewer mistakes, and without complaining about how boring it is to test and retest the same app all the time.

Plus, a passing test gives you confidence that if something changes in your code that makes a it start outputting unexpected values, you'll know because the test will fail the next time you run it.

For automated testing you _**write code**_ that runs your application and verifies that it does what it's supposed to do.

There are two main types of automated testing:
1. Unit Testing - Testing individual classes or methods.
1. Integration Testing - Testing a complete request/response cycle. An integration test will use and literally visit a URL in the web application. Data will be read from and written to the database.

We will be covering integration tests in this chapter.

## Integration Testing in Django

Django provides a test framework built on the Python standard `unittest` library. (Yes, it's called `unittest`, but it works great for integration testing too). This nifty tool allows you to simulate requests, insert test data, and inspect your application's output.

The Django startapp template will have created a `tests.py` file inside your application directory. Here's a sample class to try out in that file.

① The test class must sub-class `unittest.TestCase`

② Each function in the class must start with `test_`

```python
import unittest

class TestStringMethods(unittest.TestCase):

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        string = 'hello world'
        self.assertEqual(string.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            string.split(2)

if __name__ == '__main__':
    unittest.main()
```

Then run the tests from the command line.

```py
python manage.py test
```

This example gives you a basic structure for assembling tests. We always start with a class named `Test` plus a description of the class, or model, that we want to test.

The `TestCase` class that our test class inheritts from uses "assert" methods, such as `AssertTrue`, `AssertFalse`, and `AssertEqual`, to test that expressions result in True or False values, or that two values are equal, etc.

There are many others you can research, but these will serve our needs most of the time.

## Integration Testing Example

Think waaaaaay back to when you learned React and consider the process of creating a new `Animal` resource in your `json-server` API.

First you needed to build a JSON representation of an animal that would be boarded in a kennel. Here's a basic version.

```js
const newAnimal = {
    "name": "Jack",
    "breed": "Cocker Spaniel",
    "age": 4,
    "hasShots": true
}
```
Then you had to perform an HTTP operation of type `POST` in order to save that resource in your API.

```js
fetch("http://localhost:3000/animals", {
    "method": "POST",
    "headers": {
        "Content-Type": "application/json"
    },
    "body": JSON.stringify(newAnimal)
})
```

## Process

What's happening during this process?

1. An HTTP client sends a `POST` request to the `/animal` route.
1. The `Post()` method of the `AnimalController` is called.
1. The Django application recieves this request, routes it to the appropriate view.
1. Raw SQL, or the Django ORM, is used to insert the data into the corresponding Animal table in the database.
1. The primary key is returned from the operation and the `Id` property of the `Animal` object instance is updated with that new value.
1. A response is generated with a 200 status code and returned to the client.

For your integration tests, you are going to mimic, and automate, this process _as if you were a web browser_. Your test code will generate the data necessary and then make an HTTP request instead of a user initiating the entire process.

So, what should you test? For this course, you'll concentrate on these:

>*context*: what we send to the template  
>*content*: the rendered html  
>*response_codes*

### Create a new Animal
```py
import unittest
from django.test import TestCase
from django.urls import reverse
from .models import Animal
# from .views import <Why don't we need to do this?>

class TestAnimal(TestCase):
    def test_post_animal(self):
        # define an animal to be sent to the API
        new_animal = {
              "name": "Jack",
              "breed": "Cocker Spaniel",
              "age": 4,
              "hasShots": true
            }

        #  Use the client to send the request and store the response
        response = self.client.post(
            reverse('history:animal_form'), new_animal
          )

        # Assert
        # Getting 200 back because we have a success url (or a 302 if the view is redirecting )
        self.assertEqual(response.status_code, 200)

```
Note the reference in the code above to `self.client`. `Client` is a Python class that acts as a dummy Web browser, allowing you to test your views and interact with your Django app programmatically. The test client does not require the Web server to be running.

Let's test that we can pull data from the db and represent it as HTML? How? With 2 response properties, `context` and `content`:

`Response.context` is the context variable passed to the template by the view. This is incredibly useful for testing, because it allows us to confirm that our template is getting all the data it needs.

`Response.content` is The body of the response. This is the final page content as rendered by the view, or any error message.

### Get All Animals

```py
def test_list_animals(self):

    # Wait! Why are we saving an Animal instance again?
    # Aren't we fetching all the animals?
    # Yes, but...we are not using our actual database for these tests. Your instructor will explain.
    new_animal = Animal.objects.create(
        name="Jack",
        breed="Cocker Spaniel",
        age= 4,
        hasShots=true
    )

    # Now we can grab all the animals (meaning the one we just created) from the db
    response = self.client.get(reverse('history:animal_list'))

    # Check that the response is 200 OK.
    # This is checking for the GET request result, not the POST. We already checked that POST works in the previous test!
    self.assertEqual(response.status_code, 200)

    # Check that the rendered context contains 1 artist.
    self.assertEqual(len(response.context['animal_list']), 1)

    # Finally, test the actual rendered content as the browser would receive it
    # .encode converts from unicode to utf-8. Don't get hung up on this. It's just how we can compare apples to apples
    self.assertIn(new_animal.name.encode(), response.content)
```

## Code Coverage

You can use the Python tool [coverage.py](https://coverage.readthedocs.io/en/latest/), to ensure that your test suite has [100% coverage](http://blog.liw.fi/posts/unittest-coverage/) of your application's logic.


# Resources

* [Testing a Django web application](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Testing)
* [Writing and running tests](https://docs.djangoproject.com/en/3.0/topics/testing/overview/)
* [The Magic Tricks of Testing](https://www.youtube.com/watch?v=URSWYvyc42M) - Disregard that the example code is in Ruby. The concepts are the key takeaway.
