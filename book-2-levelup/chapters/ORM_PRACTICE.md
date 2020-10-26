# SQL -> ORM Reference

![relationship between viewset, serializer, and ORM/SQL](./images/django-rest-actors.png)

## Query all games

To retrieve all items in the Game table.

(GET) http://localhost:8000/games

#### SQL

```sql
SELECT g.id,
    g.gametype_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level
FROM levelupapi_game g
```

#### ORM

```py
games = Games.objects.all()
```

## Query single game

To retrieve a single item in the Game table.

(GET) http://localhost:8000/games/2

#### SQL

```sql
SELECT g.id,
    g.gametype_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level
FROM levelupapi_game g
WHERE g.id = 2
```

#### ORM

```py
game = Game.objects.get(pk=request.data["gameId"])
```

## Query games of a specific type

To retrieve items in the Game table that match a specific GameType.

(GET) http://localhost:8000/games?gameTypeId=2

#### SQL

```sql
SELECT g.id,
    g.gametype_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level,
    t.label game_type
FROM levelupapi_game g
LEFT JOIN levelupapi_gametype t
    ON g.gametype_id = t.id
WHERE t.id = 2
```

#### ORM

The use of the dunderscore (`__`) here represents a join operation.

```py
game_type_param = self.request.query_params.get('gameTypeId', None)
games = Games.objects.filter(gametype__id=game_type_param)
```

## Get events scheduled by gamer

To retrieve items in the Events table that belong to a specific gamer.

(GET) http://localhost:8000/profile/events
- HEADERS:
    * `Authorization: Token 5k5k5k5k5k5k5k`

#### SQL

```sql
SELECT e.id,
       e.description
FROM levelupapi_event e
LEFT JOIN levelupapi_gamer g
    ON e.gamer_id = g.id
LEFT JOIN auth_user u
    ON g.user_id= u.id
LEFT JOIN authtoken_token t
    ON t.user_id = u.id
WHERE t.key = `5k5k5k5k5k5k5k`
```

#### ORM

The use of the dunderscore (`__`) here represents a join operation.

```py
events = Event.objects.filter(organizer__user=request.auth.user)
```

## Delete events of a specific type


(DELETE) http://localhost:8000/games/5

#### SQL

```sql
DELETE FROM levelupapi_events WHERE id = 5
```

#### ORM

```py
event = Event.objects.get(pk=pk)
event.delete()
```




