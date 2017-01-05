# Generators

Generators a special function instances that will return a different value each time that the `__next__()` method is called on the instance. Let's look at a very simple example.

```py
def jenny():
  yield 8
  yield 6
  yield 7
  yield 5
  yield 3
  yield 0
  yield 9

phone_number = jenny()
print(phone_number.__next__()) # 8
print(phone_number.__next__()) # 6
print(phone_number.__next__()) # 8
print(phone_number.__next__()) # 5
print(phone_number.__next__()) # 3
print(phone_number.__next__()) # 0
print(phone_number.__next__()) # 9
print(phone_number.__next__()) # StopIteration exception raised
```

In this example, each `__next__()` method call is tied directly to the next `yield` statement in the generator function. Once there are no more `yield` statements to be executed, the `StopIteration` exception is raised on any subsequent `__next__()` call.

## yield in a loop

Next, let's add a loop inside the generator function that will print out some lyrics to the song.

```py
import sys

def jenny():
  i, lyrics = 0, ["Jenny","Jenny","who","can","I","turn","to?","You","give","me","something","I","can","hold","on","to","I","know","you'll","think","I'm","like","the","others","before","Who","saw","your","name","and","number","on","the","wall"]

  yield 8
  yield 6
  yield 7
  yield 5
  yield 3
  yield 0
  yield 9

  # With this while loop, the generator will continue to yield results
  # until there it runs out of words in the lyrics list
  while i < len(lyrics):
    yield " " + lyrics[i]
    i += 1

generator = jenny()
sys.stdout.write(str(generator.__next__())) # 8
sys.stdout.write(str(generator.__next__())) # 6
sys.stdout.write(str(generator.__next__())) # 8
sys.stdout.write(str(generator.__next__())) # 5
sys.stdout.write(str(generator.__next__())) # 3
sys.stdout.write(str(generator.__next__())) # 0
sys.stdout.write(str(generator.__next__())) # 9

# Start showing words from the lyrics
for i in range(15):
  sys.stdout.write(generator.__next__())
```