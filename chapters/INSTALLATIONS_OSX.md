# Installations

## Miniconda TBD

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
```
Once it is finished installing, run: 
```bash
source 
```

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

## Python Linter

Run the following command to install the linter we will all be using during Python development.

```sh
pip install -U pep8
```
