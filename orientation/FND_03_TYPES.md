# Types and Objects

Everything is an object in Python.

```
>>> type(True)
<class 'bool'>
>>> type(1)
<class 'int'>
>>> def test():
...   print("hello, world")
... 
>>> type(test)
<class 'function'>
>>> type(humansizes)
<class 'module'>
>>> dictionary = { "color":"blue", "size":9090 }
>>> type(dictionary)
<class 'dict'>
>>> atuple = ( "blue", 9090 )
>>> type(atuple)
<class 'tuple'>
>>> reindeer = ["dasher", "dancer", "prancer", "vixen", "olive"]
>>> type(reindeer)
<class 'list'>
>>> boy_bands = { "nsync", "one direction", "boyz II men" }
>>> type(boy_bands)
<class 'set'>
```

## Lists

A [Python list](https://docs.python.org/3.6/tutorial/datastructures.html) is like an array in JavaScript. Just an unordered, untyped collection of any values. The example below is storing strings, an integer, and even another list inside a list.

```python
junk = list()
junk = ['carrots', 'celery', 'kale', 2, ['peas', 'corn']] 
junk.insert(1, 'kidney beans')
junk.extend([True, 'tornado'])
junk.append('hurricane')
print(junk)
```

## Dictionary

A dictionary is like a literal object in JavaScript. A collection of key/value pairs.

```python
junk = dict()
junk = { 'name': 'Steve', 'age': 47, 'role': 'Head Coach' } 
junk['kids'] = 2
print(junk)
```

## Set

A is sort of like a list, except that each item is enforced to be unique. If you try to add an item that already exists in the set, no operation occurs.

```python
junk = set()
junk.add('Scott')
print(junk)
{ 'Scott' }

junk.add('Scott')
print(junk)
{ 'Scott' }
```

## Tuple

A tuple is like a list except that it's immutable. You can't add or remove things from it. What makes them useful is that iterating over the elements is faster than a list.

```python
junk = tuple()
junk = ('Joe', 'Instructor', 'Awesome')
print(junk)
```