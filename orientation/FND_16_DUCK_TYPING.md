# Duck Typing in Python

> If it looks like a duck (has the property currently being accessed), and acts like a duck (has the method that is currently being invoked), then it's a duck.

Python is not statically typed, so what something __*is*__ - meaning its type - doesn't matter until you actually try to do something with it. Python determines if the code works at runtime, while the program is running, not beforehand.

Statically typed languages will verify that the code works before you actually run the program. If you declare that a variable will hold an integer value, but later in the code, try to store a string in the variable, then your program won't compile.

```cs
int randomVariable;
randomVariable = "Scooby Doo"; // Illegal in statically typed languages
```

This article that asks ["What is duck typing?"](https://ericlippert.com/2014/01/02/what-is-duck-typing/) is worth its weight in snakes for starting to understand duck typing in Python. The reponses to the author is where the real meat is, but please don't skip reading the article itself. It provides wonderful context for the responses.