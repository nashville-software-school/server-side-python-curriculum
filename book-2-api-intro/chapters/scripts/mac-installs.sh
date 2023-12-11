PYTHON_VERSION=3.10


echo "Installing VS Code Extensions"
code --install-extension ms-python.python --force
code --install-extension ms-python.vscode-pylance --force
code --install-extension njpwerner.autodocstring --force
code --install-extension alexcvzz.vscode-sqlite --force
code --install-extension streetsidesoftware.code-spell-checker --force
code --install-extension qwtel.sqlite-viewer --force
code --install-extension ms-python.pylint --force
code --install-extension padjon.save-and-run-ext --force
code --install-extension ms-python.black-formatter --force


if command -v pyenv >/dev/null 2>&1; then
  echo "Pyenv already installed"
else
  echo "Installing Pyenv"
  brew install pyenv

  if [ $(cat ~/.zshrc | grep -c 'Configure.#pyenv') != 1 ]; then
    PYENV_ROOT="$HOME/.pyenv"
    PIPENV_DIR="$HOME/.local"
    PATH="$PIPENV_DIR/bin:$PYENV_ROOT/bin:$PATH"

    if command -v pyenv &>/dev/null; then
      PATH=$(pyenv root)/shims:$PATH
      eval "$(pyenv init -)"
    fi

    echo '# Configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_DIR="$HOME/.local"
export PATH="$PIPENV_DIR/bin:$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  export PATH=$(pyenv root)/shims:$PATH
  eval "$(pyenv init -)"
fi' >> ~/.zshrc
  else
    echo "Skipping Pyenv Configuration"
  fi


  # Verify pyenv is installed and configured
  if ! command -v pyenv >/dev/null 2>&1; then
    echo "Installation of Pyenv succeeded"
  else
    echo "\033[31m🧨 Error: Installation of pyenv failed. Contact an instructor.\033[0m"
  fi
fi


# Check if required version of Python is installed
installed_versions=$(pyenv versions)

if [ $(pyenv versions | grep -c $PYTHON_VERSION) != 1 ]; then
  echo "Installing Python version $PYTHON_VERSION"
  pyenv install ${PYTHON_VERSION}:latest
else
  echo "Python $PYTHON_VERSION already installed"
fi

# Make required version of Python the global version
INSTALLED_PYTHON_VERSION=$($installed_versions | grep -o ${PYTHON_VERSION}'.#[0-9]' | tail -1)
echo "Setting Python $INSTALLED_PYTHON_VERSION to be used globally"
pyenv global $INSTALLED_PYTHON_VERSION

# Verify the required version was set as global
if [[ "$installed_versions" == *"$PYTHON_VERSION"* ]]; then
    echo "Current Python version is $python_version"
    echo "\033[31m🧨 Error: Python $INSTALLED_PYTHON_VERSION was not set as the global version. Contact an instructor.\033[0m"
    exit 1
fi


if which pipenv >/dev/null 2>&1; then
  echo "pipenv and autopep8 already installed"
else
  python3 -m pip install pipenv autopep8 django

  # Verify installation
  if ! which pipenv >/dev/null 2>&1; then

      brew install pipenv

      if ! which pipenv >/dev/null 2>&1; then
          echo "\033[31m🧨 Error: Installation of pipenv failed. Contact an instructor.\033[0m"
          exit 1
      fi
  fi
fi

echo "\n\n"
echo "\033[31m[\033[36mnotice\033[31m]\033[0m Run the following command to complete installations"
echo "\033[31m[\033[36mnotice\033[31m]\033[0m source ~/.zshrc"
