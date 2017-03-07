# Debugging Python or Django

You might remember from the front end foundations that you can place a `debugger;` statement anywhere in your JavaScript code, and the browser will stop at that line of code when the page loads so that you can inspect the state of your application.

In Python, you will use [the debugger](https://docs.python.org/2/library/pdb.html) to accomplish the same thing.

You can place these statements anywhere in your code where you want the Python interpreter to pause, and start inspecting your code.

```py
import pdb; pdb.set_trace()
```

When the interpreter hits that line of code, the terminal session that is running the program will drop into the Python shell and you can start looking around. A simple example would be printing out values of variables.

```
> /Users/student/workspace/python/dogfood.py(56)post()
-> dog_name = "Fido"
(Pdb) print(food)
Alpo
(Pdb) print(price)
19.99
```

When you are done inspecting your code, you can exit the debugger and restart the program by typing in **run**

```
(Pdb) run
```
