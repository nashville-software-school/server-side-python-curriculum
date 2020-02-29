# Installations

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

## TablePlus

[TablePlus](https://tableplus.io/windows) will let you view, query and manage your SQLite databases during the course.

Lastly, setup an alias for TablePlus. Open the `~/.bashrc` initialization file - which is in your home directory - in your favorite code editor, and enter in the following alias.

```sh
alias tableplus="open -a """TablePlus""" "
```

Save the file, and reload your init file with the source command in the terminal.

```sh
source ~/.bashrc
```
