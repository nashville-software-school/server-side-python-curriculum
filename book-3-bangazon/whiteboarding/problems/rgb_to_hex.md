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

### Need a Hint?
See if there's any built in python methods that convert a base 10 number to a base 16

### Finished?
Can you find a way to refactor your solution?
