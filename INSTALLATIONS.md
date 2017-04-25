# Initial Course Installs

## SQL Browser

The [DB browser for SQLite](http://sqlitebrowser.org/) will let you view, query and manage your databases during the course.

## Python

### Setup

See if Python is installed.

```bash
which python
```

Check which version is installed. Most likely it will be version 2.7.x.

```bash
python --version
```

We're going to be learning version 3 of Python, and then later in the course, talk about differences between 2 and 3, because there is still a lot of version 2 code out in the wild and you will likely need to work with it.

### Windows Users

#### Installing Python

Windows does not come with Python installed. You need to visit the [Python downloads](https://www.python.org/downloads/) site and grab version 3.6 and install it. It will get installed to the `C:\Python36` directory.

After it is installed, you must add `C:\Python36` to your system path. Here's how.

1. Press your Windows key.
2. Start typing **Control**.
3. The search results should have the Windows Control Panel as the first result. Press enter.
4. When the control panel screen appears, start typing in `environment` in the search bar in the upper right corner.
5. Select the option to change environment variables. If you are presented with two options, choosing either one is fine.
6. When the screen appears, click the button at the bottom for environment variables.
7. Next, click on the `PATH` variable and choose to edit it.
8. Go to the end of the string, and enter a semi-colon, and the new path entry. `;C:\Python36`

## Managing versions

> **Prerequisite:** For pyenv to install correctly, you need the Xcode command line tools. Type this command into your terminal and wait. `xcode-select --install`

### OSX / pyenv

OSX users, you should have Homebrew installed at this point. If you don't, do it now. Then run these commands in order.

```bash
brew install pyenv
pyenv install 3.6.0
mkdir ~/workspace/python && cd $_
touch hello.py
subl .
```

After Pyenv is installed, you can make version 3.6.0 the new, globally accepted version by typing the following.

```
pyenv global 3.6.0
```

Now, when you check the version of Python with the command below, it should return 3.6.0.

```
python --version
```

---

#### Troubleshooting

If it still returns a different version, you will need to edit your `~/.bash_profile` file - or `~/.zshrc` if you installed oh-my-zsh - and follow steps 2 and 3 from the instructions on the [Basic Github Checkout section](https://github.com/yyuu/pyenv#basic-github-checkout) of pyenv's docs.

If the instructions to modify your `~/.zshenv` or `~/.bash_profile` do not work, check the complete path to the the bin folder... `~/.pyenv/versions/3.6.0/bin:` and add it to the `export 'PATH="$PYENV_ROOT/versions/3.6.0/bin:$PATH"'` command. If it still returns a different version and you are a `zsh` user, try to run the command but with your `~/.zshrc` instead.

---

### Windows

The [venv](https://docs.python.org/3/library/venv.html#module-venv) was released with Python 3.6 to give Windows user the ability to execute different versions of Python.

## Hello, world

We're going to do the traditional `Hello, world` program to start off. Put the following code in `~/workspace/python/hello.py`.

```python
print("Hello!")
print("Is it me you're looking for?")
```

In the CLI, execute the following command in the `python` directory.

```bash
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

[Anaconda](https://packagecontrol.io/packages/Anaconda)

[Djaneiro](https://github.com/squ1b3r/Djaneiro)

