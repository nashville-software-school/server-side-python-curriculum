# Comprehension

Comprehension in Python is very much like the `map()` and `filter()` array functions in JavaScript. They are ways to iterate over a collection, perform some logic on each item, and build a new collection as the result.

## List Comprehension

Let's take a lists of strings, and build a new list, with each item modified a bit.

```python
flowers = ['Lily', 'Snapdragon', 'Rose', 'Tulip']
large_flowers = ['a large ' + f for f in flowers]
```

Just like JavaScript `map()` and `filter()`, this is a shorthand way of writing a `for` loop to accomplish the same thing.

```python
for f in flowers:
    large_flowers.append('a large ' + f)
```

## Dictionary Comprehension

Dictionaries, being a collection of key/value pairs, just works slightly differently. You need to use the `items()` property on the original dictionary for the iteration.

```python
family = { 'mother': 'Margaret', 'father': 'Reginald', 'sister': 'Jenny'}
my_family = {'my ' + k + ' is ' + v for (k,v) in family.items()}
>>> my_family
{'my father is Reginald', 'my sister is Jenny', 'my mother is Margaret'}
```

## Set Comprehension

Set comprehensions are almost identical to list comprehensions. The only difference is the punctuation.

```python
possible_ratings = set(range(100))
funky_ratings = {r/2 for r in possible_ratings}
>>> funky_ratings
{0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 9.5, 38.0, 39.0, 40.0, 41.0, 10.5, 43.0, 44.0, 45.0, 46.0, 11.5, 48.0, 49.0, 12.5, 13.5, 14.5, 15.5, 16.5, 17.5, 18.5, 19.5, 20.5, 21.5, 22.5, 23.5, 24.5, 25.5, 26.5, 27.5, 28.5, 29.5, 30.5, 31.5, 32.5, 33.5, 34.5, 35.5, 36.5, 37.0, 37.5, 38.5, 39.5, 40.5, 41.5, 42.0, 42.5, 43.5, 44.5, 45.5, 46.5, 47.0, 47.5, 48.5, 49.5}
```