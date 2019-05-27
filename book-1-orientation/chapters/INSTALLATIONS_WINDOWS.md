# Installations

## TablePlus

[TablePlus](https://tableplus.io/windows) will let you view, query and manage your SQLite databases during the course.

## Python

Windows does not come with Python installed. You need to visit the [Python downloads](https://www.python.org/downloads/) site and grab version 3.7 and install it. It will get installed to the `C:\Python37` directory.

After it is installed, you must add `C:\Python37` to your system path. Here's how.

1. Press your Windows key.
2. Start typing **Control**.
3. The search results should have the Windows Control Panel as the first result. Press enter.
4. When the control panel screen appears, start typing in `environment` in the search bar in the upper right corner.
5. Select the option to change environment variables. If you are presented with two options, choosing either one is fine.
6. When the screen appears, click the button at the bottom for environment variables.
7. Next, click on the `PATH` variable and choose to edit it.
8. Go to the end of the string, and enter a semi-colon, and the new path entry. `;C:\Python37`


## Hello, world

We're going to do the traditional `Hello, world` program to start off. Put the following code in `~/workspace/python/hello.py`.

```python
print("Hello!")
print("Is it me you're looking for?")
```

In the CLI, execute the following command in the `python` directory.

```sh
python hello.py
```

## Python interpreter

You can use the CLI interpreter to enter and run some code that you just want to test out without having to put it in a file and running it.

```
╰─$ python
Python 3.6.0 (default, Jul 14 2015, 19:46:27)
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.39)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> i_am_awesome = True
>>> if i_am_awesome:
...   print("bow down to me")
...
bow down to me
```

# Optional, Handy Tooling

[iPython](https://ipython.readthedocs.io/en/stable/install/index.html) to get color-highlighted output and some other nifty features to enhance your terminal experience

[Anaconda](https://packagecontrol.io/packages/Anaconda)

[Djaneiro](https://github.com/squ1b3r/Djaneiro)
