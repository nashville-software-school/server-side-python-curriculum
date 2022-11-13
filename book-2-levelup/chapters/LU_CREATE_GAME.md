# Creating New Games

## Client Request Functions

First add the following two functions to your **`gameData.js`** file so that you can get all game types to display in a dropdown in the form, and perform a POST request to save a new game to the database.

The URL for both of these fetch calls will start with `http://localhost:8000/`, but you need to ensure that you specify the correct resource after the `/`. Look in your server's `urls.py` module to ensure you target the correct resource with these functions.

```js
const createGame = (game) => new Promise((resolve, reject) => {
  fetch("", {})
    .then()
    .catch();
});

const getGameTypes = () => new Promise((resolve, reject) => {
  fetch("", {})
    .then()
    .catch();
});

export { getGames, createGame, getGameTypes };
```

## Game Form

Now create a **`GameForm`** component and add the code below. Notice that the button's click handler invokes the `createGame()` function that is defined in the manager.

> #### `components/games/GameForm.js`

```jsx
import { useRouter } from 'next/router';
import PropTypes from 'prop-types';
import { useState, useEffect } from 'react';
import { Button, Form } from 'react-bootstrap';
import { createGame, getGameTypes } from '../../utils/data/gameData';

const GameForm = ({ user }) => {
  const [gameTypes, setGameTypes] = useState([]);
  /*
  Since the input fields are bound to the values of
  the properties of this state variable, you need to
  provide some default values.
  */
  const [currentGame, setCurrentGame] = useState({
    skillLevel: 1,
    numberOfPlayers: 0,
    title: '',
    maker: '',
    gameTypeId: 0,
  });
  const router = useRouter();

  useEffect(() => {
    // TODO: Get the game types, then set the state
  }, []);

  const handleChange = (e) => {
    // TODO: Complete the onChange function
  };

  const handleSubmit = (e) => {
    // Prevent form from being submitted
    e.preventDefault();

    const game = {
      maker: currentGame.maker,
      title: currentGame.title,
      number_of_players: Number(currentGame.numberOfPlayers),
      skill_level: Number(currentGame.skillLevel),
      game_type: Number(currentGame.gameTypeId),
      user_id: user.uid
    };

    // Send POST request to your API
    createGame(game).then(() => router.push('/games'));
  };

  return (
    <>
      <Form onSubmit={handleSubmit}>
        <Form.Group className="mb-3">
          <Form.Label>Title</Form.Label>
          <Form.Control name="title" required value={currentGame.title} onChange={handleChange} />
        </Form.Group>
        {/* TODO: create the rest of the input fields */}

        <Button variant="primary" type="submit">
          Submit
        </Button>
      </Form>
    </>
  );
};

GameForm.propTypes = {
  user: {
    uid: PropTypes.string.isRequired,
  }.isRequired,
};

export default GameForm;
```

## Create New Game page

Create a Page that will allow for the creation of a new game using the GameForm

> #### `pages/games/new.js`

```jsx
import GameForm from '../../components/game/GameForm';
import { useAuth } from '../../utils/context/authContext';

const NewGame = () => {
  const { user } = useAuth();
  return (
    <div>
      <h2>Register New Game</h2>
      <GameForm user={user} />
    </div>
  );
};

export default NewGame;
```

## Create Game Button

Add the following button to the header of the game page component JSX. When clicked, it will redirect the browser to a new route.

```jsx
import { Button } from 'react-bootstrap';

<Button
onClick={() => {
    router.push('/games/new');
}}
>
Register New Game
</Button>
```

## On Your Own

- Complete the TODO items within the Create Game Form
- Create the new event form
- Make a new route for the new component
- Add a “Register new Event” button to the event list that redirects to the form
