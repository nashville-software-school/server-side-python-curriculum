# Lists

## Explanation

A list in Python is an ordered collection of items that can hold a variety of object types, such as numbers, strings, and even other lists. Lists are mutable, meaning their elements can be changed after they are created. They are defined by enclosing elements in square brackets [].

## When to Use

Lists are used when you need to maintain an ordered collection of items that may need to be changed or updated. Common use cases include:

1. Storing sequences of items in a specific order.
2. Maintaining a collection where elements are frequently added, removed, or modified.
3. Implementing simple collections that require iteration or indexing.

## Implementation Example

Let's create a simple to-do list application where you can add, remove, and display tasks. Create a new sub-directory of your choice in the `workspace` directory to work on the exercises in this column.

Create a Python module named `todos.py` and place the following code in it.

```py
# Initialize an empty to-do list
todo_list = []

# Function to add a task
def add_task(task):
    todo_list.append(task)
    print(f"Task '{task}' added.")

# Function to remove a task
def remove_task(task):
    if task in todo_list:
        todo_list.remove(task)
        print(f"Task '{task}' removed.")
    else:
        print(f"Task '{task}' not found.")

# Function to display all tasks
def display_tasks():
    print("To-Do List:")
    for task in todo_list:
        print(f"- {task}")

# Adding tasks
add_task("Read a book")
add_task("Write some code")
add_task("Go for a walk")

# Displaying tasks
display_tasks()

# Removing a task
remove_task("Write some code")

# Displaying tasks again
display_tasks()
```


## Practice: Favorite Movies List

Now that you have seen an example how lists work, your task is to create a simple application to manage a list of your favorite movies. This task will help you practice adding, removing, displaying, and counting items in a list. Follow the instructions below:

### Instructions

1. Create a new module named `my_movies.py`.
2. **Initialize an Empty List**: Create an empty list named `favorite_movies`.
3. **Add Movies to the List**: Write a function `add_movie(movie)` that adds a movie to the list and prints a message indicating the movie was added.
4. **Remove Movies from the List**: Write a function `remove_movie(movie)` that removes a movie from the list if it exists, and prints a message indicating the movie was removed or a message if the movie was not found.
5. **Display the List**: Write a function `display_movies()` that prints all the movies in the list.
6. **Count Movies in the List**: Write a function `count_movies()` that prints the number of movies in the list.
7. **Find a Movie**: Write a function `find_movie(movie)` that checks if a movie is in the list and prints a message indicating whether the movie was found or not.
8. **Clear the List**: Write a function `clear_movies()` that removes all movies from the list and prints a message indicating the list has been cleared.

## Optional Algorithmic Practice: Planet List

Want to practice your algorithmic thinking, but with Python syntax? First, [learn a bit about **tuples**](https://www.pythontutorial.net/python-basics/python-tuples/) which are lists, but have far fewer operations, and are immutable.

### Setup

```sh
cd ~/workspace/python/lists
echo 'planet_list = ["Mercury", "Mars"]' >> planets.py
```

### Instructions

Open the **planets.py** module in Visual Studio Code to get started.

1. Use `append()` to add Jupiter and Saturn at the end of the list.
1. Use the `extend()` method to add another list of the last two planets in our solar system to the end of the list.
1. Use `insert()` to add Earth, and Venus in the correct order.
1. Use `append()` again to add Pluto to the end of the list.
1. Now that all the planets are in the list, slice the list in order to get the rocky planets into a new list called `rocky_planets`.
1. Being good amateur astronomers, we know that Pluto is now a dwarf planet, so use the `del` operation to remove it from the end of `planet_list`.

## Challenge: Iterating over planets

| Planet   | Spacecraft   |
|----------|--------------|
| Mercury  | Mariner 10, MESSENGER |
| Venus    | Venera 1-16, Mariner 2, Mariner 5, Mariner 10, Pioneer Venus 1 and 2, Vega 1 and 2, Galileo, Magellan, Cassini, MESSENGER, Venus Express, Parker Solar Probe |
| Mars     | Mariner 4, Mariner 6 and 7, Mariner 9, Viking 1 and 2, Mars Pathfinder, Mars Odyssey, Spirit, Opportunity,  Phoenix, Dawn, Curiosity, InSight, Perseverance
| Jupiter  | Pioneer 10 and 11, Voyager 1 and 2, Ulysses, Galileo, Cassini, New Horizons, Juno |
| Saturn   | Pioneer 11, Voyager 1 and 2, Cassini |
| Uranus   | Voyager 2 |
| Neptune  | Voyager 2 |
| Pluto    | New Horizons |

1. Create another list containing tuples. Each tuple will hold the name of a spacecraft that we have launched, and the names of the planet(s) that it has visited, or landed on.
    ```py
    # Example spacecraft list
    spacecraft = [
       ("Cassini", "Saturn"),
       ("Viking", "Mars"),
    ]
    ```
2. Iterate over your list of planets, and inside that loop, iterate over the list of tuples. Print, for each planet, which satellites have visited it. Your output should match this.

> Hint: Use tuple unpacking _(a.k.a. destructuring)_ to make your code have a good balance between brevity and readability

```txt
Cassini has visited
-----------------------
Saturn

Voyager 1 has visited
-----------------------
Jupiter
Saturn
```