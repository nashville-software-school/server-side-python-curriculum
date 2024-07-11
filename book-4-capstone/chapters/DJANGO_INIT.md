# How to Start a Django Project

First, decide on a name for your project. For example, if you want to build a capstone about plants, then `plants` is the single word you will use in the next step. If you want to build a capstone about managing a construction project, then `construct` is a single word you will use in the next step.

In your terminal, go to your **workspace** directory.

Then create a new directory following this pattern `{single word you chose}project`. If your capstone is about plants, you will create a directory named `plantproject`. If it is about construction projects, you will create a directory named `constructproject`.


`cd` to that directory.

Keep that single word in mind that you chose for your project. Then run the following command in the terminal.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nashville-software-school/course-bash-scripts/main/python/django-setup.sh)"
```

Once the process completes, run `pipenv shell` to activate the virtual environment that was created for your project.
