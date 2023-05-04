# Deshawn's Dog Walking API

## Project Setup

Create a project directory and initialize a virtual environment for your project with the following commands.

```sh
mkdir -p ~/workspace/deshawn
```
```sh
cd ~/workspace/deshawn
```
```sh
pipenv shell
```

Run the following command in your terminal and wait for the entire process to complete.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nashville-software-school/bangazon-llc/cohort-58/book-3-levelup/chapters/scripts/deshawn-setup.sh)"
```

Once that's done, open up the directory in VS Code.

```sh
code .
```

## Select Python Interpreter

Once VS Code starts up, press <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows) to open the Command Palette, and select "Python: Select Interpreter".

Find the option that looks similar to the following example. Yours will not look identical, but the word "deshawn" will be in there:

`Python 3.9.10 (deshawn-NiFBQu_i) ~/.virtualenvs/deshawn-NiFBQu_i/bin/python`

## Start in Debug Mode

Start your Django project in Debug Mode with the keyboard shortcut of (Or use F5) <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>D</kbd> (Mac), or <kbd>SHIFT</kbd><kbd>ALT</kbd><kbd>D</kbd> (Windows). A new terminal panel at the bottom of VS Code will appear and you will see your server running.

![image of the debug terminal output](./images/debug-terminal.png)

If you don't see this, call your team lead immediately.
