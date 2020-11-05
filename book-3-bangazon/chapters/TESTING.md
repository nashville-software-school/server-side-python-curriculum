# Creating API Integration Tests

## Setup

When you want to have a test suite that verifies that your code continues to work as developers make changes, here's the quick list of things you need to

1. Create `tests` directory in project.
1. Create `tests/{resource_name}_tests.py` module for each resource.
1. Write test classes in each test module.
1. Create `tests/__init__.py` module.
1. Import test classes into `__init__.py`.
1. Run `python manage.py test tests -v 1` to execute all test classes.

## Learning Objective

After implementing the code in this chapter, you should be able to understand the purpose of an integration test, and be able to apply code that verifies that API operations perform the tasks that you expect.

## Summary

Time to get meta. Integration tests are a separate application that you write whose sole job is to verify that the implementation code does what it's supposed to do. This is important in a large project where there are many developers all working on big fixes and new features.

The integration tests ensure that as bugs are fixed, and new features are built, that teammates do not break existing functionality.

The entire team works on designing the integration tests and agree that when a certain endpoint is requested, with a certain HTTP method, that the end result should be _x_. Then the test is written to check if _x_ is achieved when a request is made.

Remember that humans are extraordinarily adept at introducing unintended bugs into a codebase while development is happening. The integration tests serve as a neutral third-party to ensure that those bugs don't make it to production.

## Implementation Code

### Package Init Module

Just like with your views and models in your API application, your `tests` directory should be made into a Python package by implementing a dunder-init module.

> #### `levelup/tests/__init__.py`

```py
from .game_tests import GateTests
```

### Test Case(s) Module

Now create the module that contains the first integration test.

1. For each resource you want to test (e.g. games, events, etc.) there will be a class. In this module, the `GameTests` class will contain all integration tests for games.
1. If you need to have any resources created *before* a test is run, you can do that in `setUp()`. In the code below, the set up function does two things:
    1. Registers a user in the testing database.
    1. Seeds the testing database with a game type
1. Then define functions for running the integration tests. All functions that contain integration tests **must** start with `test_`. What you put after that is up to you. Just make sure it is very descriptive. If the test is for modifying a game, then a good name for that function would be `test_modifying_a_game_record_via_put_method()`.

> #### `levelup/tests/game_tests.py`

```py
import json
from rest_framework import status
from rest_framework.test import APITestCase
from levelupapi.models import GameType


class GameTests(APITestCase):
    def setUp(self):
        """
        Create a new account and create sample category
        """
        url = "/register"
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
        # Initiate request and capture response
        response = self.client.post(url, data, format='json')

        # Parse the JSON in the response body
        json_response = json.loads(response.content)

        # Store the auth token
        self.token = json_response["token"]

        # Assert that a user was created
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # SEED DATABASE WITH ONE GAME TYPE
        # This is needed because the API does not expose a /gametypes
        # endpoint for creating game types
        gametype = GameType()
        gametype.label = "Board game"
        gametype.save()


    def test_create_game(self):
        """
        Ensure we can create a new game.
        """
        # DEFINE GAME PROPERTIES
        url = "/games"
        data = {
            "gameTypeId": 1,
            "skillLevel": 5,
            "title": "Clue",
            "maker": "Milton Bradley",
            "numberOfPlayers": 6,
        }

        # Make sure request is authenticated
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)

        # Initiate request and store response
        response = self.client.post(url, data, format='json')

        # Parse the JSON in the response body
        json_response = json.loads(response.content)

        # Assert that the game was created
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # Assert that the properties on the created resource are correct
        self.assertEqual(json_response["title"], "Clue")
        self.assertEqual(json_response["maker"], "Milton Bradley")
        self.assertEqual(json_response["skill_level"], 5)
        self.assertEqual(json_response["number_of_players"], 6)
```

## Running the Test

1. Open a terminal and change directory to your project directory.
1. Run the following command
    ```sh
    python manage.py test tests -v 1
    ```
1. Look at the output and see if the test passes.
    ![expected test output in terminal](./images/initial-test-output.png)
1. If your test passed, move on to the next section, otherwise, call in an instructor.

## Testing GET


## Testing PUT


## Testing DELETE

