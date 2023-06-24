# Deshawn's Dog Walking API

## Project Setup

### Workspace Settings: Ensure your Workspace settings are correct
Open the VS Code Command Palette <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows), and search for **Open User Settings (JSON)**, and add the following JSON to file that appears.

NOTE: You may already have a key "files.exclude". If so, just add `"**/__pycache__": true`.

```json
   "python.formatting.autopep8Path": "paste in the output from the which command",
   "python.linting.pylintEnabled": true,
   "python.analysis.diagnosticSeverityOverrides": {
     "reportGeneralTypeIssues": "none"
   },
   "files.exclude": {
    "**/__pycache__": true
  },
```

Use this link to create a repo for this chapter: https://githubtools.reppedintech.com/u/nss-evening-web-development/deshawn
- Clone this repo down to your machine
- Once that's done, open up the directory in VS Code: `code .`
- Once in your repo, start your shell: `pipenv shell`
- Install your dependencies: `pipenv install`

## Select Python Interpreter

Once VS Code starts up:

1. Press <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Mac), or <kbd>Ctrl</kbd><kbd>SHIFT</kbd><kbd>P</kbd> (Windows) to open the Command Palette
2. Select "Python: Select Interpreter".
3. Find the option that looks similar to the following example. Yours will not look identical, but the word "deshawn" will be in there:

`Python 3.9.10 (deshawn-NiFBQu_i) ~/.virtualenvs/deshawn-NiFBQu_i/bin/python`

## Start in Debug Mode

Start your Django project in Debug Mode with the keyboard shortcut of <kbd>⌘</kbd><kbd>SHIFT</kbd><kbd>D</kbd> (Mac), or <kbd>SHIFT</kbd><kbd>ALT</kbd><kbd>D</kbd> (Windows) (Or you can try to use F5). A new terminal panel at the bottom of VS Code will appear and you will see your server running.

![image of the debug terminal output](./images/debug-terminal.png)

If you don't see this, ask an instructor for help by putting in a help ticket: https://github.com/orgs/nss-evening-web-development/discussions
