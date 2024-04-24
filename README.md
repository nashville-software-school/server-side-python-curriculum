# Python and Django Course

Welcome to the Python and Django course for Nashville Software School.

## Installations

Run the appropriate script in one of your terminal windows. Location is irrelevant.

### Mac Users

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nashville-software-school/course-bash-scripts/main/python/mac-installs.sh)"
```

### Windows and Linux Users

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nashville-software-school/course-bash-scripts/main/python/wsl-ubuntu-installs.sh)"
```

After running this script, if you **do** **not** see a message that says "Success! You are ready to start coding with Python", reach out to an instructor.
To make sure the script was actually successful run `python3 --version` if you do not get a number that starts with 3, close the terminal, reopen and try that command again. If the version still does not start with 3, let an instructor know.

## Python Formatting

1. If you don't have VS Code open, open it now. It doesn't matter for which project.
2. Open the **Command Palette** and search for "settings"
3. Choose **Preferences: Open User Settings**
4. Type "python format" in the settings search
5. In the **Editor: Default Formatter** section, choose _Black Formatter_ as the default formatter.
6. You can close the settings window now.
