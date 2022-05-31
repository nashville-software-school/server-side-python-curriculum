PYTHON_VERSION=3.9.10


echo Installing Pyenv
brew install pyenv

echo Installing Python version $PYTHON_VERSION
pyenv install $PYTHON_VERSION

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
pyenv global $PYTHON_VERSION

current_python=$(echo python3 --version)

if [current_python != $PYTHON_VERSION];
then
    current_python
    echo "Could not set the global python version let an instructor know"
    exit 
fi

echo Install pipenv
python3 -m pip install pipenv autopep8

pipenv --version
if $?;
then
    echo "Could not find pipenv, let an instructor know"
    exit
fi


echo "Installing VS Code Extensions"
code --install-extension ms-python.python --force
code --install-extension ms-python.vscode-pylance --force
code --install-extension njpwerner.autodocstring --force
code --install-extension alexcvzz.vscode-sqlite --force
code --install-extension streetsidesoftware.code-spell-checker --force


