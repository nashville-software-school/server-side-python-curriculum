# Installations

## TablePlus

[TablePlus](https://tableplus.io/) will let you view, query and manage your SQLite databases during the course. Visit their site and click the "Download for Mac" button.

## Python via Pyenv

### XCode Prerequisite

For `pyenv` to install correctly, you need the Xcode command line tools. Type the following command into your terminal and wait for the installation to complete.

```
xcode-select --install
```

### Install Pyenv

```bash
brew install pyenv
pyenv install 3.7.3
pyenv global 3.7.3
```

Now, when you check the version of Python with the command below, it should return 3.7.3.

```
python --version
```

---

#### Troubleshooting


If it still returns a different version, you will need to edit your `~/.zshrc` file. Add the following to the bottom of the file.

```sh
# Configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```

## Hello, world

We're going to do the traditional `Hello, world` program to start off. Put the following code in `~/workspace/python/hello.py`.

```python
print("Hello!")
print("Is it me you're looking for?")
```

In the CLI, execute the following command in the `~/workspace/python` directory.

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
