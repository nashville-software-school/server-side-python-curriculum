# Listing Games and Events in the Client

Now that we’ve added a way to get all games and events from the server, let’s display those lists in react.

## Client Code

You can start off with this starter React code to request and display a list of games from the API.

> #### `utils/data/gameData.js`

```jsx
import { clientCredentials } from '../client';

const getGames = () => new Promise((resolve, reject) => fetch(`${clientCredentials.databaseURL}/games`)
  .then((response) => response.json())
  .then(resolve)
  .catch(reject));

// eslint-disable-next-line import/prefer-default-export
export { getGames };
```

> #### `components/GameCard.js`

```jsx
import PropTypes from 'prop-types';
import React from 'react';
import { Card } from 'react-bootstrap';

const GameCard = ({
  title, //
  maker,
  numberOfPlayers,
  skillLevel,
}) => (
  <Card className="text-center">
    <Card.Header>{title}</Card.Header>
    <Card.Body>
      <Card.Title>By: {maker}</Card.Title>
      <Card.Text>{numberOfPlayers} players needed</Card.Text>
    </Card.Body>
    <Card.Footer className="text-muted">Skill Level: {skillLevel}</Card.Footer>
  </Card>
);

GameCard.propTypes = {
  title: PropTypes.string.isRequired,
  maker: PropTypes.string.isRequired,
  numberOfPlayers: PropTypes.number.isRequired,
  skillLevel: PropTypes.number.isRequired,
};

export default GameCard;
```

> #### `pages/index.js`

```jsx
import React, { useEffect, useState } from 'react';
import GameCard from '../components/GameCard';
import { getGames } from '../utils/data/gameData';

function Home() {
  const [games, setGames] = useState([]);

  useEffect(() => {
    getGames().then((data) => setGames(data));
  }, []);

  return (
    <article className="games">
      <h1>Games</h1>
      {games.map((game) => (
        <section key={`game--${game.id}`} className="game">
          <GameCard title={game.title} maker={game.maker} numberOfPlayers={game.number_of_players} skillLevel={game.skill_level} />
        </section>
      ))}
    </article>
  );
}

export default Home;
```

## Practice: Listing Events

Add an `eventData` file and `Event` page in the react code to display a list of event cards. The route should be `/events` for the event list.
