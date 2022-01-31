# Listing Games and Events in the Client
Now that we’ve added a way to get all games and events from the server, let’s display those lists in react.

## Client Code

You can start off with this starter React code to request and display a list of games from the API. Note the `Authorization` header added to the fetch call. This will be in every fetch call to the database to let the server know which user is logged in.

> #### `src/components/game/GameManager.js`

```jsx
export const getGames = () => {
    return fetch("http://localhost:8000/games", {
        headers:{
            "Authorization": `Token ${localStorage.getItem("lu_token")}`
        }
    })
        .then(response => response.json())
}
```

> #### `src/components/game/GameList.js`

```jsx
import React, { useEffect } from "react"
import { getGames } from "./GameManager.js"

export const GameList = (props) => {
    const [ games, setGames ] = useState([])

    useEffect(() => {
        getGames().then(data => setGames(data))
    }, [])

    return (
        <article className="games">
            {
                games.map(game => {
                    return <section key={`game--${game.id}`} className="game">
                        <div className="game__title">{game.title} by {game.maker}</div>
                        <div className="game__players">{game.number_of_players} players needed</div>
                        <div className="game__skillLevel">Skill level is {game.skill_level}</div>
                    </section>
                })
            }
        </article>
    )
}
```

> #### `src/components/ApplicationViews.js`

```jsx
import React from "react"
import { Route } from "react-router-dom"
import { GameList } from "./game/GameList.js"

export const ApplicationViews = () => {
    return <>
        <main style={{
            margin: "5rem 2rem",
            lineHeight: "1.75rem"
        }}>
            <Route exact path="/">
                <GameList />
            </Route>
        </main>
    </>
}
```

## Practice: Listing Events
Add an `EventManager` file and `EventList` component in the react code to display a list of events. The route should be `/events` for the event list. 
