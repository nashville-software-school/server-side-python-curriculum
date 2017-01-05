# Python Method Decorators

If you believe you had a good comprehension of how function were first order objects in JavaScript, then Python decorators should be fairly easy to grasp. This is because a Python decorator is simply a function that accepts a function as an argument, and then returns another function.

## How it looks in JavaScript

Here's the mechanism in JavaScript. A function reference is passed to another, decorating function. The decorating function returns a new function that, itself, invokes the original function and decorates its return value.

```js
// Returns a simple string
function message () {
  return 'Nashville Software School';
}

/* 
  Decorator function that will invoke any original function,
  and wrap an h1 tag around its return value
*/
function heading (messageFunction) {
  return function final_function () {
    return `<h1>${messageFunction()}</h1>`;
  }
}


final_function_reference = heading(message);
decorated_value = final_function_reference(); // "<h1>Nashville Software School</h1>"
```

## How it looks in Python

First, let's define a decorator method. Its purpose is to the take the string output of a different method, put it between two `h1` tags and return a method that will output the final string.

```py
def heading(message_function):
  def final_function():
    return "<h1>{0}</h1>".format(message_function());
  return final_function
```

Now we can decorate another method by preceding it with `@heading`.

By providing the `@heading` decorator, what Python does is pass the `message` method into the `heading` method as an argument.

```py
@heading
def message():
  return "Nashville Software School"
```

Now when you execute the `message()` method, what's actually being invoked is the `final_function()` method that the `heading()` returns.

```
Python 3.3.6 (default, Nov 16 2015, 10:56:55) 
[GCC 4.2.1 Compatible Apple LLVM 7.0.0 (clang-700.1.76)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> message()
'<h1>Nashville Software School</h1>'
```

## HTML Output Formatting with Decorators

You can add as many decorators to a method that you like. Just make sure that each one returns a method that can be passed to the next one.

```py
def bold(message_function):
  def final_function():
    return "<strong>{0}</strong>".format(message_function());
  return final_function

def italic(message_function):
  def final_function():
    return "<em>{0}</em>".format(message_function());
  return final_function

def underline(message_function):
  def final_function():
    return "<u>{0}</u>".format(message_function());
  return final_function


@bold
@italic
@underline
def message():
  return "Nashville Software School"

print(message())
```
