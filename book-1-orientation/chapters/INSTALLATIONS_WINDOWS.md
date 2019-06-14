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

## Python Linter

Run the following command to install the linter we will all be using during Python development.

```sh
pip install -U pep8
```

## Django

Django is the application framework you will be using for most of your server-side work.

```sh
pip install -U django
```


## Visual Studio Code Extensions

* [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
* [Python Extension Pack](https://marketplace.visualstudio.com/items?itemName=donjayamanne.python-extension-pack)
* [AREPL](https://marketplace.visualstudio.com/items?itemName=almenon.arepl)
* [Python Test Explorer](https://marketplace.visualstudio.com/items?itemName=LittleFoxTeam.vscode-python-test-adapter)

## TablePlus

[TablePlus](https://tableplus.io/windows) will let you view, query and manage your SQLite databases during the course.