# Palindromes
Write a function that takes a single string argument. The function should return the shortest possible palindrome of the string. Letters should be added to the end of the string not removed.

## Examples

```py
make_palindrome('abcdc')
# returns
'abcdcba'

make_palindrome('ababab')
#returns
'abababa'
```

## Starter code
```py
def make_palindrome(num):
    # add your solution here
    pass

def test_make_palindrome_solution():
    assert make_palindrome('abcdc') == 'abcdcba'
    assert make_palindrome('ababab') == 'abababa'
    assert make_palindrome('bccaaac') == 'bccaaaccb'

```


### Need a Hint?
Try copying and reversing the string parameter. Think of the original and the reverse copy overlapping each other till it makes the shortest string

```
a b c d (c
         c) d c b a

a b c (d c 
       c d) c b a

a b (c d c 
     c d c) b a
```

### Finished?
Can you solve it a different way?
