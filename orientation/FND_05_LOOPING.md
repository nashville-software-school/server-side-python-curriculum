# Looping Over Collections

## Looping Lists

```python
flowers = ['Lily', 'Snapdragon', 'Rose', 'Tulip']
for f in flowers:
    large_flowers.append('a large ' + f)

print(large_flowers)

['a large Lily', 'a large Snapdragon', 'a large Rose', 'a large Tulip']
```

## Looping Dictionaries

Using a `for` loop on a dictionary, will loop over the keys.

```python
family = { 'mother': 'Margaret', 'father': 'Reginald', 'sister': 'Jenny'}
for f in family:
    print(f)

mother
father
sister
```

If you want to look at both the keys and the values, you can loop over the `items()` property.

```python
family = { 'mother': 'Margaret', 'father': 'Reginald', 'sister': 'Jenny'}
for key, value in family.items():
    print(key, value)

mother Margaret
father Reginald
sister Jenny
```

## Looping Sets

Identical to lists.

```python
cars = { 'Lexus', 'Chevy', 'Jeep' }
for c in cars:
    print(c)

Lexus
Chevy
Jeep
```