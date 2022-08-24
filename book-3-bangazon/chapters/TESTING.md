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

Just like with your views and models in your API application, your `tests` directory should be made into a Python package by implementing a dunder-init module. Add the `__init__.py` file to the `tests` directory. This file can be blank since we will not be importing the test files to other folders.

### Test Case(s) Module

Now create the module that contains the first integration test.

* For each resource you want to test (e.g. games, events, etc.) there will be a class. In this module, the GameTests class will contain all integration tests for games.
* The `setUp` method includes any code you want to run before the tests start. In this case we want to add a users token to the header so we can make requests with the test client.

* Then define functions for running the integration tests.

#### NOTE: All functions that contain integration tests ***must*** start with `test_`

What you put after that is up to you... Just make sure it is very descriptive. For example, if you are writing a test for modifying a Game, a good name for that function would be `test_modifying_a_game_record_via_put_method()`.



### Test Functions

Now, we can define the functions for running the integration tests.

### Test - CREATE A New Game

Copy and paste the code below into your `test_game_view.py` module. The `tests` module should be a sibling to the `levelupapi` and `levelup` folders

> #### `./tests/test_game_view.py`

```py
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token
from levelupapi.models import Game, Gamer
from levelupapi.views.game import GameSerializer

class GameTests(APITestCase):

    # Add any fixtures you want to run to build the test database
    fixtures = ['users', 'tokens', 'gamers', 'game_types', 'games', 'events']
    
    def setUp(self):
        # Grab the first Gamer object from the database and add their token to the headers
        self.gamer = Gamer.objects.first()
        token = Token.objects.get(user=self.gamer.user)
        self.client.credentials(HTTP_AUTHORIZATION=f"Token {token.key}")

    def test_create_game(self):
        """Create game test"""
        url = "/games"

        # Define the Game properties
        # The keys should match what the create method is expecting
        # Make sure this matches the code you have
        game = {
            "title": "Clue",
            "maker": "Milton Bradley",
            "skill_level": 5,
            "number_of_players": 6,
            "game_type": 1,
        }

        response = self.client.post(url, game, format='json')

        # The _expected_ output should come first when using an assertion with 2 arguments
        # The _actual_ output will be the second argument
        # We _expect_ the status to be status.HTTP_201_CREATED and it _actually_ was response.status_code
        self.assertEqual(status.HTTP_201_CREATED, response.status_code)
        
        # Get the last game added to the database, it should be the one just created
        new_game = Game.objects.last()

        # Since the create method should return the serialized version of the newly created game,
        # Use the serializer you're using in the create method to serialize the "new_game"
        # Depending on your code this might be different
        expected = GameSerializer(new_game)

        # Now we can test that the expected ouput matches what was actually returned
        self.assertEqual(expected.data, response.data)
```

## Running the Test(s)

1. Open the Terminal and navigate to your project directory.

1. Run the test(s) with the following command:

    ```sh
    python3 manage.py test
    ```

2. Read the output and see if the test passes.

    ![expected test output in terminal](./images/initial-test-output.png)

3. Once your test is passing, move on to the next section!

### If your test is NOT passing...

* ***READ*** the output in your terminal to find out why.
* ***ASK*** your classmates if they have seen the same issue.
* ***DISCUSS*** potential solutions, and troubleshoot together.

### If your test is STILL not passing...

* ***CALL*** in an instructor for help before moving on to the next section.

----

## Test - GET A Single Game

Add the function below to your `GameTests` class.

> #### `./tests/test_game_view.py`

```py
    def test_get_game(self):
        """Get Game Test
        """
        # Grab a game object from the database
        game = Game.objects.first()

        url = f'/games/{game.id}'

        response = self.client.get(url)

        self.assertEqual(status.HTTP_200_OK, response.status_code)

        # Like before, run the game through the serializer that's being used in view
        expected = GameSerializer(game)

        # Assert that the response matches the expected return data
        self.assertEqual(expected.data, response.data)
```

----

## Test - LIST all Games

Add the function below to your `GameTests` class.
```py
    def test_list_games(self):
        """Test list games"""
        url = '/games'

        response = self.client.get(url)
        
        # Get all the games in the database and serialize them to get the expected output
        all_games = Game.objects.all()
        expected = GameSerializer(all_games, many=True)

        self.assertEqual(status.HTTP_200_OK, response.status_code)
        self.assertEqual(expected.data, response.data)
```

----

## Test - UPDATE A Game

Add the function below to your `GameTests` class.

```py
    def test_change_game(self):
        """test update game"""
        # Grab the first game in the database
        game = Game.objects.first()

        url = f'/games/{game.id}'

        updated_game = {
            "title": f'{game.title} updated',
            "maker": game.maker,
            "skill_level": game.skill_level,
            "number_of_players": game.number_of_players,
            "game_type": game.game_type.id
        }

        response = self.client.put(url, updated_game, format='json')

        self.assertEqual(status.HTTP_204_NO_CONTENT, response.status_code)

        # Refresh the game object to reflect any changes in the database
        game.refresh_from_db()

        # assert that the updated value matches
        self.assertEqual(updated_game['title'], game.title)
```

----

## Test - DELETE A Game

Add the function below to your `GameTests` class.

```py
    def test_delete_game(self):
        """Test delete game"""
        game = Game.objects.first()

        url = f'/games/{game.id}'
        response = self.client.delete(url)

        self.assertEqual(status.HTTP_204_NO_CONTENT, response.status_code)

        # Test that it was deleted by trying to _get_ the game
        # The response should return a 404
        response = self.client.get(url)
        self.assertEqual(status.HTTP_404_NOT_FOUND, response.status_code)
```


