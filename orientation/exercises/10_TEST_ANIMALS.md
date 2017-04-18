# Testing the Animals

> **Note:** This code exercise will be part of a live coding session with the instructor. Feel free to try it on your own beforehand and come to class with questions, or just wait until live coding starts.

## Setup

```
mkdir -p ~/workspace/python/exercises/testing && cd $_
touch animals.py
```

1. Copy the contents of [animals.py](./assets/animal.py) into the file you just created.

## Overview

As a team, we'll be building unit test coverage for all the functionality of the code in the `animal` module. We'll discuss how writing tests often affect the implementation code, and how to think bout covering edge cases in your test suit.

## Instructions

Write test cases to verify the I/O of the following methods of `Animal` and `Dog`.

1. In the test class' `setUpClass()` method, create an instance of `Animal` and `Dog`.
1. Animal object has the correct `name` property.
1. Set a species and verify that the object property of `species` has the correct value.
1. Invoking the `walk()` method set the correct speed on the both objects.
1. The animal object is an instance of `Animal`.
1. The dog object is an instance of `Dog`.

## Test Discovery

Read the [Test Discovery section](https://docs.python.org/3.3/library/unittest.html#unittest-test-discovery) of the Python docs. It explains how you can run all tests inside a directory. This allows you to split your unit test suite into many, smaller, more maintainable modules, and the use a pattern matcher to find tests in all matching files.

```
python -m unittest discover -s . -p "Test*.py" -v
```

