PYTHON_VERSION=3.9

echo "Installing VS Code Extensions"
code --install-extension ms-python.python --force
code --install-extension ms-python.vscode-pylance --force
code --install-extension njpwerner.autodocstring --force
code --install-extension alexcvzz.vscode-sqlite --force
code --install-extension qwtel.sqlite-viewer --force
code --install-extension mtxr.sqltools-driver-sqlite --force
code --install-extension streetsidesoftware.code-spell-checker --force
code --install-extension ms-vscode-remote.remote-wsl --force
code --install-extension padjon.save-and-run-ext --force
code --install-extension ms-python.pylint --force
code --install-extension ms-python.black-formatter --force


echo "Update Ubuntu and install required packages"
sudo apt update
sudo apt install -y gcc make build-essential openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libffi-dev wget liblzma-dev curl xz-utils libncurses5-dev python3-openssl llvm sqlite

echo "Install pyenv"
curl https://pyenv.run | bash

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
  python3 -m pip install pipenv autopep8 django
else
  echo Skipping pipenv and autopep8 install
fi

if [[ $(which pipenv) == "pipenv not found" ]];
then
    echo "Could not find pipenv, let an instructor know"
    return 0
fi

echo Success! You are ready to start coding with Python
