
# Installations for WSL and Ubuntu users

## Visual Studio Code Extensions
**Before continuing, make sure you have the “Remote - WSL” extension installed in VS Code. **
1. If you don’t have the “Remote - WSL” extension, install it now.
2. Reopen VS Code from the terminal, then continue with the following instructions
Install these extensions to get your VS Code editor set up for writing Python code.

* [Pylance][1]
* [Python Extension Pack][2]
* [SQLite][3]
* [Python Test Explorer][4]
* [Python Docstring Generator][5]
* [Code Spell Checker][6]

## Install Required Libraries

Run the following two commands in Ubuntu terminal

```sh
sudo apt update

sudo apt install -y gcc make build-essential openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libffi-dev python3 python3-pip wget liblzma-dev curl xz-utils libncurses5-dev python3-openssl llvm
```

### Install Pyenv
`pyenv` is a python version manager. We’ll use `pyenv` to install a specific version of python. This makes it easy to switch to a different version of python if needed

```bash
curl https://pyenv.run | bash
```

### Update the `.zshrc` file
There’s a few lines to add to the .zshrc file before we can use `pyenv`
1. Open the .zshrc file with in VS Code:  `code ~/.zshrc`
2. Scroll to the bottom of the file and add these lines
	```bash
	# Configure pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	export PIPENV_DIR="$HOME/.local"
	export PATH="$PIPENV_DIR/bin:$PYENV_ROOT/bin:$PATH"

	if command -v pyenv 1>/dev/null 2>&1; then
	  export PATH=$(pyenv root)/shims:$PATH
	  eval "$(pyenv init -)"
	fi
	```
3. Save and exit VS Code
4. Back in the terminal reload the window to load the changes to the file: `source ~/.zshrc`

### Download Python
1. In the same terminal window download the version of python: `pyenv install 3.9.10`
2. After the download finishes set that version of python to the global version: `pyenv global 3.9.10`
3. Now your computer’s python version should be using 3.9.10. Check it with `python3 --version`. **If something other than 3.9.10 comes back, reach out to an instructor now.**

## Install Pipenv

This tool will manage any libraries that is needed for each of your projects. It creates a “container”, or virtual environment to add the different libraries to the current project. In some ways, `pipenv` does the same thing as the `node_modules` and `package.json`. It tells the program what libraries it needs (`package.json`) and stores those libraries for use within the project (`node_modules`). You’ll learn more about this as we use it in later projects.
1. Install the package globally:
	```sh
	python3 -m pip install pipenv
	```
2. Check that the package is usable: `pipenv --version`
3. **If you get a message saying `command pipenv not found`, reach out to an instructor now.**



## Book 1 React Clients

### Nashville Kennels

Visit the [kennel-template][7] repository and click the **`Use this template`** button to get the React client copied to your Github account.

![animation showing how to use template][image-1]

Then clone your repository into your workspace directory.


### Daily Journal

Visit the [daily-journal-template][8] repository and click the **`Use this template`** button to get the React client copied to your Github account.

Then clone your repository into your workspace directory.

[1]:	https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance
[2]:	https://marketplace.visualstudio.com/items?itemName=donjayamanne.python-extension-pack
[3]:	https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite
[4]:	https://marketplace.visualstudio.com/items?itemName=LittleFoxTeam.vscode-python-test-adapter
[5]:	https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring
[6]:	https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
[7]:	https://github.com/nashville-software-school/nashville-kennels-template
[8]:	https://github.com/nashville-software-school/daily-journal-react-template

[image-1]:	./images/kennel-template-process.gif