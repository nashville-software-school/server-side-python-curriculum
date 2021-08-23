# Creating API Integration Tests

## Setup

When you want to have a test suite which verifies that your code continues to work, even as developers make changes, here's the quick list of things you need to do:

1. Create `tests` directory in your project.
1. Create `tests/{resource_name}_tests.py` modules for each resource.
1. Write test classes in each test module.
1. Create `tests/__init__.py` module.
1. Import test classes into `__init__.py`.
1. Run `python3 manage.py test tests -v 1` to execute all test classes.

## Learning Objectives

After implementing the code in this chapter, you should be able to:

* You should be able to explain the purpose of an integration test
* You should be able to apply code to verify that API operations work as expected.
* You should be able to clarify the purpose of the `setUp()` method.
* You should be able to read a failed test output to

## Summary

Time to get meta. Integration tests are a separate application that you write whose sole job is to verify that the implementation code does what it's supposed to do. This is important in a large project where there are many developers all working on big fixes and new features.

Integration tests ensure that teammates do not accidentally break existing functionality during development. The entire team works collaboratively to design the integration tests, and determine what the expected result should be when a certain type of request is sent to a certain endpoint. Then, the test is written to check whether the result is achieved when a request is sent to that endpoint, or not.

Remember that humans are extraordinarily adept at introducing unintended bugs into a codebase while development is happening. The integration tests serve as a neutral third-party to ensure that those bugs don't make it to production.

## Implementation Code

### Package Init Module

Just like with your views and models in your API application, your `tests` directory should be made into a Python package by implementing a dunder-init module.

> #### `levelup/tests/__init__.py`

```py
from .game_tests import GameTests
```

### Test Case(s) Module

1. Now create the module that will contain your first integration test.

1. In this module, the `GameTests` class will contain all integration tests for Games.

###### *NOTE: Each resource you want to test (e.g. Games, Events, etc.) will have it's own class inside it's own module.*

### Setting Up Your Tests

If you need to create any resources *before* a test is run, you can do that in the `setUp()` method.

For example, before we can run a test for creating a Game, we need to make sure we have a Gamer, a Token, and a GameType. In the code below, notice that the `setUp` function does three things:

1. Registers a Gamer in the testing database.
1. Captures the authentication Token from the response.
1. Seeds the testing database with a GameType.

### Test Functions

Now, we can define the functions for running the integration tests.

#### NOTE: All functions that contain integration tests ***must*** start with `test_`

What you put after that is up to you... Just make sure it is very descriptive. For example, if you are writing a test for modifying a Game, a good name for that function would be `test_modifying_a_game_record_via_put_method()`.

### Test - Create A Game

Copy and paste the code below into your `game_tests.py` module.

> #### `levelup/tests/game_tests.py`

```py
import json

from rest_framework import status
from rest_framework.test import APITestCase
from levelupapi.models import GameType, Game

class GameTests(APITestCase):
    """
    GameTests
    """
    def setUp(self):
        """
        Create a new User account, and create sample game type
        """

        # Define the URL path for registering a Gamer
        url = "/register"

        # Define the Gamer properties
        data = {
            "username": "steve",
            "password": "Admin8*",
            "email": "steve@stevebrownlee.com",
            "address": "100 Infinity Way",
            "phone_number": "555-1212",
            "first_name": "Steve",
            "last_name": "Brownlee",
            "bio": "Love those gamez!!"
        }

        # Initiate POST request and capture the response
        response = self.client.post(url, data, format='json')

        # Store the Token from the response
        self.token = 'Token ' + response.data['token']

        # Assert that the response status code is 201 CREATED
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # SEED THE DATABASE WITH A GAMETYPE

        # Since the API does not expose a
        # /gametypes PATH path for creating GameTypes,
        # we have to create a new instance of GameType
        # and save it to the testing database
        game_type = GameType()
        game_type.label = "Board game"
        game_type.save()

    def test_create_game(self):
        """
        Ensure we can create (POST) a new Game.
        """

        # Define the URL path for creating a new Game
        url = "/games"

        # Define the Game properties
        data = {
            "name": "Clue",
            "maker": "Milton Bradley",
            "skillLevel": 5,
            "numberOfPlayers": 6,
            "gameTypeId": 1,
            "description": "More fun than a Barrel Of Monkeys!"
        }

        # Use the TOKEN to authenticate the request
        self.client.credentials(HTTP_AUTHORIZATION=self.token)

        # Initiate POST request and capture the response
        response = self.client.post(url, data, format='json')

        # Assert that the response status code is 201 CREATED
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"], 1)
        self.assertEqual(response.data["name"], "Clue")
        self.assertEqual(response.data["maker"], "Milton Bradley")
        self.assertEqual(response.data["skill_level"], 5)
        self.assertEqual(response.data["number_of_players"], 6)
        self.assertEqual(response.data["game_type"], 1)
        self.assertEqual(response.data["description"], "More fun than a Barrel Of Monkeys!")
```

## Running the Test(s)

1. In the Terminal, navigate to your project directory and run the following command:

    ```sh
    python3 manage.py test tests -v 1
    ```

1. Look at the output and see if the test passes.

    ![expected test output in terminal](./images/initial-test-output.png)

1. If your test passed, move on to the next section, otherwise, call in an instructor.

----

## Test - Get A Single Game

Add the function below to your `GameTests` class.

> #### `levelup/tests/game_tests.py`

```py
    def test_get_game(self):
        """
        Ensure we can GET an existing game.
        """

        # Create a new instance of Game
        game = Game()
        game.gamer_id = 1
        game.name = "Monopoly"
        game.maker = "Milton Bradley"
        game.skill_level = 5
        game.number_of_players = 4
        game.game_type_id = 1
        game.description = "Real-Estate, and Finance, and Bankruptcy, OH MY!"

        # Save it to the testing database
        game.save()

        # Define the URL path for getting a single Game
        url = f'/games/{game.id}'

        # Use the TOKEN to authenticate the request
        self.client.credentials(HTTP_AUTHORIZATION=self.token)

        # Initiate GET request and capture the response
        response = self.client.get(url)

        # Assert that the response status code is 200 OK
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"], 1)
        self.assertEqual(response.data["name"], "Monopoly")
        self.assertEqual(response.data["maker"], "Milton Bradley")
        self.assertEqual(response.data["skill_level"], 5)
        self.assertEqual(response.data["number_of_players"], 4)
        self.assertEqual(response.data["game_type"], 1)
        self.assertEqual(response.data["description"], "Real-Estate, and Finance, and Bankruptcy, OH MY!")
```

----

## Test - Update A Game

Add the function below to your `GameTests` class.

```py
    def test_change_game(self):
        """
        Ensure we can change an existing game.
        """

        # Create a new instance of Game
        # and save it to the testing database.
        game = Game()
        game.game_type_id = 1
        game.skill_level = 5
        game.name = "Sorry"
        game.maker = "Milton Bradley"
        game.number_of_players = 4
        game.gamer_id = 1
        game.description = "Not Sorry!"

        game.save()

        # Define the URL path for updating an existing Game
        url = f'/games/{game.id}'

        # Define NEW Game properties
        data = {
            "name": "Sorry",
            "maker": "Hasbro",
            "gameTypeId": 1,
            "skillLevel": 2,
            "numberOfPlayers": 4,
            "description": "Is it too late now to say sorry?"
        }

        # Use the TOKEN to authenticate the request
        self.client.credentials(HTTP_AUTHORIZATION=self.token)

        # Initiate PUT request and capture the response
        response = self.client.put(url, data, format="json")

        # Assert that the response status code is 204 no content
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # GET the Game again to verify the changes
        response = self.client.get(url)

        # Assert that the response status code is 200 OK
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"], 1)
        self.assertEqual(response.data["name"], "Sorry")
        self.assertEqual(response.data["maker"], "Hasbro")
        self.assertEqual(response.data["skill_level"], 2)
        self.assertEqual(response.data["number_of_players"], 4)
        self.assertEqual(response.data["game_type"], 1)
        self.assertEqual(response.data["description"], "Is it too late now to say sorry?")
```

----

## Test - Delete a Game

Add the function below to your `GameTests` class.

```py
    def test_delete_game(self):
        """
        Ensure we can delete an existing game.
        """


        # Create a Game and save it to the testing database
        game = Game()
        game.game_type_id = 1
        game.skill_level = 5
        game.name = "Sorry"
        game.maker = "Milton Bradley"
        game.number_of_players = 4
        game.gamer_id = 1
        game.description = "It's too late to apologize."
        game.save()

        # Define the URL path for deleting an existing Game
        url = f'/games/{game.id}'

        # Use the TOKEN to authenticate the request
        self.client.credentials(HTTP_AUTHORIZATION=self.token)

        # Initiate DELETE request and capture the response
        response = self.client.delete(url)

        # Assert that the response status code is 204 no content
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # GET Game again
        response = self.client.get(url)

        # Assert that the response status code is 404 NOT FOUND
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
```
