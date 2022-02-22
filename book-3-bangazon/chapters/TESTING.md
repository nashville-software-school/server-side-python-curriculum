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

After implementing the code in this chapter, you should be able to...

* Explain the purpose of an integration test.
* Apply code to verify that API operations work as expected.
* Identify which resources need to be created in setUp() before running a test.
* Read test output errors to debug failed tests.

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

Now create the module that contains the first integration test.

* For each resource you want to test (e.g. games, events, etc.) there will be a class. In this module, the GameTests class will contain all integration tests for games.

* If you need to have any resources created before a test is run, you can do that in setUp(). In the code below, the set up function does three things:

    * Registers a Gamer in the testing database.
    * Captures the authentication Token from the response.
    * Seeds the testing database with a GameType.

* Then define functions for running the integration tests.

#### NOTE: All functions that contain integration tests ***must*** start with `test_`

What you put after that is up to you... Just make sure it is very descriptive. For example, if you are writing a test for modifying a Game, a good name for that function would be `test_modifying_a_game_record_via_put_method()`.

### Test Functions

Now, we can define the functions for running the integration tests.

### Test - CREATE A New Game

Copy and paste the code below into your `game_tests.py` module.

> #### `levelup/tests/game_tests.py`

```py
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token

from levelupapi.models import GameType, Game

class GameTests(APITestCase):
    def setUp(self):
        """
        Create a new Gamer, collect the auth Token, and create a sample GameType
        """

        # Define the URL path for registering a Gamer
        url = '/register'

        # Define the Gamer properties
        gamer = {
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
        response = self.client.post(url, gamer, format='json')

        # Store the TOKEN from the response data
        self.token = Token.objects.get(pk=response.data['token'])

        # Use the TOKEN to authenticate the requests
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)

        # Assert that the response status code is 201 (CREATED)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # SEED THE DATABASE WITH A GameType and Game
        # This is necessary because the tests use a seperate database that has nothing in it
        # until rows are created in the set up

        self.game_type = GameType.objects.create(label="Board Game")
        self.game = Game.objects.create(
            gamer_id=1,
            title="Sorry",
            maker="Milton Bradley",
            skill_level=5,
            number_of_players=4,
            game_type=self.game_type,
        )
        

    def test_create_game(self):
        """
        Ensure we can create (POST) a new Game.
        """

        # Define the URL path for creating a new Game
        url = "/games"

        # Define the Game properties
        game = {
            "title": "Clue",
            "maker": "Milton Bradley",
            "skill_level": 5,
            "number_of_players": 6,
            "game_type": self.game_type.id,
        }

        # Initiate POST request and capture the response
        response = self.client.post(url, game, format='json')

        # Assert that the response status code is 201 (CREATED)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"]['user'], self.token.user_id)
        self.assertEqual(response.data["title"], game['title'])
        self.assertEqual(response.data["maker"], game['maker'])
        self.assertEqual(response.data["skill_level"], game['skill_level'])
        self.assertEqual(
            response.data["number_of_players"], game['number_of_players'])
        self.assertEqual(response.data["game_type"]['id'], game['game_type'])
```

## Running the Test(s)

1. Open the Terminal and navigate to your project directory.

1. Run the test(s) with the following command:

    ```sh
    python3 manage.py test tests -v 1
    ```

1. Read the output and see if the test passes.

    ![expected test output in terminal](./images/initial-test-output.png)

1. Once your test is passing, move on to the next section!

### If your test is NOT passing...

* ***READ*** the output in your terminal to find out why.
* ***ASK*** your classmates if they have seen the same issue.
* ***DISCUSS*** potential solutions, and troubleshoot together.

### If your test is STILL not passing...

* ***CALL*** in an instructor for help before moving on to the next section.

----

## Test - GET A Single Game

Add the function below to your `GameTests` class.

> #### `levelup/tests/game_tests.py`

```py
    def test_get_game(self):
        """
        Ensure we can GET an existing game.
        """
        # Define the URL path for getting a single Game
        url = f'/games/{self.game.id}'

        # Initiate GET request and capture the response
        response = self.client.get(url)

        # Assert that the response status code is 200 (OK)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"]['id'], self.game.gamer_id)
        self.assertEqual(response.data["title"], self.game.title)
        self.assertEqual(response.data["maker"], self.game.maker)
        self.assertEqual(response.data["skill_level"], self.game.skill_level)
        self.assertEqual(response.data["number_of_players"], self.game.number_of_players)
        self.assertEqual(response.data["game_type"]['id'], self.game.game_type_id)
```

----

## Test - UPDATE A Game

Add the function below to your `GameTests` class.

```py
    def test_change_game(self):
        """
        Ensure we can change an existing game.
        """
        # Define the URL path for updating an existing Game
        url = f'/games/{self.game.id}'

        # Define NEW Game properties
        new_game = {
            "title": "Sorry",
            "maker": "Hasbro",
            "skill_level": 2,
            "number_of_players": 4,
            "game_type": 1,
        }

        # Initiate PUT request and capture the response
        response = self.client.put(url, new_game, format="json")

        # Assert that the response status code is 204 (NO CONTENT)
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # Initiate GET request and capture the response
        response = self.client.get(url)

        # Assert that the response status code is 200 (OK)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # Assert that the values are correct
        self.assertEqual(response.data["gamer"]['id'], self.token.user_id)
        self.assertEqual(response.data["title"], new_game['title'])
        self.assertEqual(response.data["maker"], new_game['maker'])
        self.assertEqual(
            response.data["skill_level"], new_game['skill_level'])
        self.assertEqual(
            response.data["number_of_players"], new_game['number_of_players'])
        self.assertEqual(response.data["game_type"]['id'], new_game['game_type'])

```

----

## Test - DELETE A Game

Add the function below to your `GameTests` class.

```py
    def test_delete_game(self):
        """
        Ensure we can delete an existing game.
        """
        # Define the URL path for deleting an existing Game
        url = f'/games/{self.game.id}'

        # Initiate DELETE request and capture the response
        response = self.client.delete(url)

        # Assert that the response status code is 204 (NO CONTENT)
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # Initiate GET request and capture the response
        response = self.client.get(url)

        # Assert that the response status code is 404 (NOT FOUND)
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
```


