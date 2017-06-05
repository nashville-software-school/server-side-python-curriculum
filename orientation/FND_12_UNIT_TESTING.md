# Unit Testing

You got an introduction to unit testing during your front end course work. On the server side, unit testing becomes easier, and more straightfoward because you don't have user interfaces to worry about. No functional testing at all.

Server side code is all about constrained inputs and verifiable outputs. Perfect for unit testing.

Read a [walkthrough of setting up unit tests](https://docs.python.org/3.5/library/unittest.html) in Python.

Just like with Jasmine for your JavaScript, you should use your unit tests as part of your design stage. Write as many unit tests as you can for your initial classes and methods. Once you feel you have good coverage for the basic logic of your application, then you begin writing simple implementations of the code in order to make the tests pass.

## Example

Python provides its own unit testing framework named, appropriately, `unittest`. Here's a sample class for running unit tests.

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
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

if __name__ == '__main__':
    unittest.main()
```

## Test Discovery

Read the [Test Discovery section](https://docs.python.org/3.3/library/unittest.html#unittest-test-discovery) of the Python docs. It explains how you can run all tests inside a directory. This allows you to split your unit test suite into many, smaller, more maintainable modules, and the use a pattern matcher to find tests in all matching files.

```
python -m unittest discover -s . -p "Test*.py" -v
```

## Code Coverage

You can use the Python tool [coverage.py](https://coverage.readthedocs.io/en/latest/), to ensure that your test suite has [100% coverage](http://blog.liw.fi/posts/unittest-coverage/) of your application's logic.


# Resources

* [Unit Testing with Python](https://www.pluralsight.com/courses/unit-testing-python) on PluralSight (you should be able to get a free trial for 10 days)
* [The Magic Tricks of Testing](https://www.youtube.com/watch?v=URSWYvyc42M) - Disregard that the example code is in Ruby. The concepts are the key takeaway.
* [Improve Your Python: Understanding Unit Testing](https://jeffknupp.com/blog/2013/12/09/improve-your-python-understanding-unit-testing/) 
* [Dive Into Python 3: Unit Testing](http://www.diveintopython3.net/unit-testing.html)
