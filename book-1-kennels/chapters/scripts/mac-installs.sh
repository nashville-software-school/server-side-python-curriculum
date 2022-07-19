PYTHON_VERSION=3.9

if [ $(brew list | grep -c pyenv) != 1 ];
then
  echo Installing Pyenv
  brew install pyenv
else
  echo "Skipping Pyenv install"
fi

if [ $(cat ~/.zshrc | grep -c 'Configure pyenv') != 1 ];
then
  echo Adding Pyenv Configuration
  echo -e '\n\n# Configure pyenv\n
  export PYENV_ROOT="$HOME/.pyenv"\n
  export PIPENV_DIR="$HOME/.local"\n
  export PATH="$PIPENV_DIR/bin:$PYENV_ROOT/bin:$PATH"\n

  if command -v pyenv 1>/dev/null 2>&1; then\n
    \texport PATH=$(pyenv root)/shims:$PATH\n
    \teval "$(pyenv init -)"\n
  fi\n' >> ~/.zshrc
  source ~/.zshrc
else
  echo Skipping Pyenv Configuration
fi

if [ $(pyenv versions | grep -c $PYTHON_VERSION) != 1 ];
then
  echo Installing Python version $PYTHON_VERSION
  pyenv install ${PYTHON_VERSION}:latest
else
  echo Skipping $PYTHON_VERSION install
fi

INSTALLED_PYTHON_VERSION=$(pyenv versions | grep -o ${PYTHON_VERSION}'.*[0-9]' | tail -1)
pyenv global $INSTALLED_PYTHON_VERSION


if [ $(python3 --version | grep -c $INSTALLED_PYTHON_VERSION) != 1 ];
then
    echo "Could not set the global python version let an instructor know"
    return 0
fi

if [ $(python3 -m pip list | grep -c pipenv) != 1 ];
then 
  echo Install pipenv and autopep8
  python3 -m pip install pipenv autopep8
else
  echo Skipping pipenv and autopep8 install
fi

if [[ $(which pipenv) == "pipenv not found" ]];
then
    echo "Could not find pipenv, let an instructor know"
    return 0
fi


echo "Installing VS Code Extensions"
code --install-extension ms-python.python --force
code --install-extension ms-python.vscode-pylance --force
code --install-extension njpwerner.autodocstring --force
code --install-extension alexcvzz.vscode-sqlite --force
code --install-extension streetsidesoftware.code-spell-checker --force



echo Success! You are ready to start coding with Python
