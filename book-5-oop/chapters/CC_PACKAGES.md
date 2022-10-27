# Organizing Animals

For this next stage of the process, you are going to move all of the classes out of `animals.py` into their own packages.

1. Rename `animals.py` to `index.py`.
1. Make directories for each animal category _(i.e. swimming, walking, etc...)_.
1. Make each directory a package with the dunder-init module.
2. Create an individual module for each animal in the appropriate package _(e.g. swimming/fish.py, walking/pony.py)_. Then move the class definitions that are currently in `animal.py` into the corresponding module.
3. Import all of the animal classes for that package into the dunder-init.
4. Import each animal into the `.py` module via packages.