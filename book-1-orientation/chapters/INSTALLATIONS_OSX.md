# Installations

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

#### Troubleshooting pyenv


If it still returns a different version, you will need to edit your `~/.zshrc` file. Add the following to the bottom of the file.

```sh
# Configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```

If you are a Mac user on Mojave, and receive a similar error to the one below when trying to run `pyenv install 3.7.3`

```
BUILD FAILED (OS X 10.14.6 using python-build 20180424)

Inspect or clean up the working tree at /var/folders/r5/snljcx4x3dx8ccckm7hhdgy80000gn/T/python-build.20191008104728.34069 Results logged to /var/folders/r5/snljcx4x3dx8ccckm7hhdgy80000gn/T/python-build.20191008104728.34069.log
```

Run the following command in your terminal:
 ```
 sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target / 
 ```


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
* [MagicPython](https://marketplace.visualstudio.com/items?itemName=magicstack.MagicPython)
* [AREPL](https://marketplace.visualstudio.com/items?itemName=almenon.arepl)
* [Python Test Explorer](https://marketplace.visualstudio.com/items?itemName=LittleFoxTeam.vscode-python-test-adapter)

## TablePlus

[TablePlus](https://tableplus.io/) will let you view, query and manage your SQLite databases during the course. Visit their site and click the "Download for Mac" button.

Lastly, setup an alias for TablePlus. Open the `~/.zshrc` initialization file - which is in your home directory - in your favorite code editor, and enter in the following alias.

```sh
alias tableplus="open -a """TablePlus""" "
```

Save the file, and reload your init file with the source command in the terminal.

```sh
source ~/.zshrc
```
