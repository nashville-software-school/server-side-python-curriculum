# Creating New Games

## Client Request Functions

First, add a new state variable to your game provider to manage game types.

```jsx
const [ gameTypes, setTypes ] = useState([])
```

Then add the following two functions to your **`GameProvider`** component so that you can get all game types to display in a dropdown in the form, and perform a POST request to save a new game to the database.

* The URL resource for creating games is `/games`
* The URL resource for getting types is `/gametypes`

Make sure you add the `Authorization` header to both fetch requests.

```jsx
const createGame = game => {
    return fetch("", { })
        .then()
        .then()
}

const getGameTypes = () => {
    return fetch("", { })
        .then()
        .then()

}
```

Make sure you add both of those functions to the `value` object for the context provider at the bottom of the module.

## Game Form

Now create a **`GameForm`** component and add the code below. Notice that the button's click handler invokes the `createGame()` function that is defined in the provider.

> #### `src/components/game/GameForm.js`

```jsx
import React, { useContext, useState, useEffect } from "react"
import { GameContext } from "./GameProvider.js"


export const GameForm = props => {
    const { createGame, getGameTypes, gameTypes } = useContext(GameContext)

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

    /*
        Get game types on initialization so that the <select>
        element presents game type choices to the user
    */
    useEffect(() => {
        getGameTypes()
    }, [])

    /*
        Update the `currentGame` state variable every time
        the state of one of the input fields changes
    */
    const handleControlledInputChange = (event) => {
        const newGameState = Object.assign({}, currentGame)
        newGameState[event.target.name] = event.target.value
        setCurrentGame(newGameState)
    }

    return (
        <form className="gameForm">
            <h2 className="gameForm__title">Register New Game</h2>
            <fieldset>
                <div className="form-group">
                    <label htmlFor="title">Title: </label>
                    <input type="text" name="title" required autoFocus className="form-control"
                        value={currentGame.title}
                        onChange={handleControlledInputChange}
                    />
                </div>
            </fieldset>

            {/* You create the rest of the input fields for each game property */}

            <button type="submit"
                onClick={evt => {
                    // Prevent form from being submitted
                    evt.preventDefault()

                    // Send POST request to your API
                    createGame({
                        maker: currentGame.maker,
                        title: currentGame.title,
                        numberOfPlayers: parseInt(currentGame.numberOfPlayers),
                        skillLevel: parseInt(currentGame.skillLevel),
                        gameTypeId: parseInt(currentGame.gameTypeId)
                    })
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
        props.history.push({ pathname: "/games/new" })
    }}
>Register New Game</button>
```

Then add the following route to the **`ApplicationViews`** component. Make sure you make it a child of the correct provider(s).

```jsx
<Route exact path="/games/new">
    <GameForm />
</Route>
```
