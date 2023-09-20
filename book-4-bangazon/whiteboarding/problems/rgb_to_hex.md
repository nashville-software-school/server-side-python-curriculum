# RGB to Hexadecimal

Write a function that takes in RGB color values and converts it into the hexadecimal color. The function should take three arguments for the R, G, and B values. If the R, G, or B values are outside of the 0 to 255 range they should be converted to the closest number in that range

## Examples

```py
rgb(255, 255, 255) # returns FFFFFF
rgb(255, 255, 300) # returns FFFFFF
rgb(0,0,0) # returns 000000
rgb(148, 0, 211) # returns 9400D3
rgb(-20,275,125) # returns 00FF7D
```

## Starter Code

```py
def rgb_to_hex(red, green, blue):
    # add your solution here
    pass

def test_rgb_solution():
    assert rgb_to_hex(255, 255, 255) == 'FFFFFF'
    assert rgb_to_hex(255, 255, 300) == 'FFFFFF'
    assert rgb_to_hex(0, 0, 0) == '000000'
    assert rgb_to_hex(148, 0, 211) == '9400D3'
    assert rgb_to_hex(254,253,252) == "FEFDFC"
    assert rgb_to_hex(220, 67, 368) == "DC43FF"
```

## Need a Hint?

See if there's any built in python methods that convert a base 10 number to a base 16

## Finished?

Run `pytest` in the terminal to see if your solution passes
Can you find a way to refactor your solution?
