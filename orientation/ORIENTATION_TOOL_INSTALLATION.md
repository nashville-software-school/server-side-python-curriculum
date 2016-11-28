# Installing required software

## SQL Browser

The [DB browser for SQLite](http://sqlitebrowser.org/) will let you view, query and manage your databases during the course.

## Python

### Windows Users

#### Installing Python

Windows does not come with Python installed. You need to visit the [Python downloads](https://www.python.org/downloads/) site and grab the most recent, stable version (3.5.2) and install it. It will get installed to the `C:\Python35` directory.

After it is installed, you must add `C:\Python35` to your system path. Here's how.

1. Press your Windows key.
2. Start typing **Control**.
3. The search results should have the Windows Control Panel as the first result. Press enter.
4. When the control panel screen appears, start typing in `environment` in the search bar in the upper right corner.
5. Select the option to change environment variables. If you are presented with two options, choosing either one is fine.
6. When the screen appears, click the button at the bottom for environment variables.
7. Next, click on the `PATH` variable and choose to edit it.
8. Go to the end of the string, and enter a semi-colon, and the new path entry. `;C:\Python35`

### OSX Users

See if Python is installed.

```bash
which python
```

Check which version is installed. Most likely it will be version 2.7.x.

```bash
python --version
```

### Managing versions

You should have Homebrew installed at this point. If you don't, do it now. Then, run these commands in order.

```bash
brew install pyenv
pyenv install 3.5.2
mkdir ~/workspace/python && cd $_
touch hello.py
subl .
```

After Pyenv is installed, you can make version 3.5.2 the new, globally accepted version by typing the following.

```
pyenv global 3.5.2
```

Now, when you check the version of Python with the command below, it should return 3.5.2.

```
python --version
```

## Django

Installing Python view Homebrew will automatically install the `pip` package manager. It's Python's version of `bower` or `npm` that you learned in the front end. Let's use `pip` to install Django 1.10.3.

```
pip install Django==1.10.3
```

Django is, by far, the most robust, mature and popular framework for building Python-based applications. You will learn how to use Django to build a server-generated MVC application, and how to use the [Django Rest Framework](http://www.django-rest-framework.org/) application add-on to build an API.

## Django REST Framework

```
pip install djangorestframework
```