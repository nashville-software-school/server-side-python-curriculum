# Creating New Games

## Client Request Functions

First add the following two functions to your **`GameManager`** file so that you can get all game types to display in a dropdown in the form, and perform a POST request to save a new game to the database.

The URL for both of these fetch calls will start with `http://localhost:8000/`, but you need to ensure that you specify the correct resource after the `/`. Look in your server's `urls.py` module to ensure you target the correct resource with these functions.

Make sure you add the `Authorization` header to both fetch requests.

```js
export const createGame = (game) => {
    return fetch("", { })
        .then()
}

export const getGameTypes = () => {
    return fetch("", { })
        .then()
}
```

## Game Form

Now create a **`GameForm`** component and add the code below. Notice that the button's click handler invokes the `createGame()` function that is defined in the manager.

> #### `src/components/game/GameForm.js`

```jsx
import React, { useState, useEffect } from "react"
import { useHistory } from 'react-router-dom'
import { createGame, getGameTypes } from './GameManager.js'


export const GameForm = () => {
    const history = useHistory()
    const [gameTypes, setGameTypes] = useState([])

    /*
        Since the input fields are bound to the values of
        the properties of this state variable, you need to
        provide some default values.
    */
    const [currentGame, setCurrentGame] = useState({
        skillLevel: 1,
        numberOfPlayers: 0,
        title: "",
        maker: "",
        gameTypeId: 0
    })

    useEffect(() => {
        // TODO: Get the game types, then set the state
    }, [])

    const changeGameState = (domEvent) => {
        // TODO: Complete the onChange function
    }

    return (
        <form className="gameForm">
            <h2 className="gameForm__title">Register New Game</h2>
            <fieldset>
                <div className="form-group">
                    <label htmlFor="title">Title: </label>
                    <input type="text" name="title" required autoFocus className="form-control"
                        value={currentGame.title}
                        onChange={changeGameState}
                    />
                </div>
            </fieldset>

            {/* TODO: create the rest of the input fields */}

            <button type="submit"
                onClick={evt => {
                    // Prevent form from being submitted
                    evt.preventDefault()

                    const game = {
                        maker: currentGame.maker,
                        title: currentGame.title,
                        number_of_players: parseInt(currentGame.numberOfPlayers),
                        skill_level: parseInt(currentGame.skillLevel),
                        game_type: parseInt(currentGame.gameTypeId)
                    }

                    // Send POST request to your API
                    createGame(game)
                        .then(() => history.push("/games"))
                }}
                className="btn btn-primary">Create</button>
        </form>
    )
}
```

## Create Game Button

Add the following button to the header of the game list component JSX. When clicked, it will redirect the browser to a new route.

```jsx
<button className="btn btn-2 btn-sep icon-create"
    onClick={() => {
        history.push({ pathname: "/games/new" })
    }}
>Register New Game</button>
```

Then add the following route to the **`ApplicationViews`** component.

```jsx
<Route exact path="/games/new">
    <GameForm />
</Route>
```


# On your own
- Create the new event form 
- Make a new route for the new component
- Add a “Register new Event” button to the event list that redirects to the form
