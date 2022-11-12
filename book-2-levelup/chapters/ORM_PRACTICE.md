# SQL -> ORM Reference

![relationship between viewset, serializer, and ORM/SQL](./images/django-rest-actors.png)

## Query all games

To retrieve all items in the Game table.

(GET) <http://localhost:8000/games>

### SQL (All Games)

```sql
SELECT g.id,
    g.game_type_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level
FROM levelupapi_game g
```

### ORM (All Games)

```python
games = Games.objects.all()
```

## Query single game

To retrieve a single item in the Game table.

(GET) <http://localhost:8000/games/2>

### SQL (Single Game)

```sql
SELECT g.id,
    g.game_type_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level
FROM levelupapi_game g
WHERE g.id = 2
```

### ORM (Single Game)

```python
game = Game.objects.get(pk=request.data["gameId"])
```

## Query games of a specific type

To retrieve items in the Game table that match a specific GameType.

(GET) <http://localhost:8000/games?gameTypeId=2>

### SQL (Game By Type)

```sql
SELECT g.id,
    g.game_type_id,
    g.title,
    g.maker,
    g.gamer_id,
    g.number_of_players,
    g.skill_level,
    t.label game_type
FROM levelupapi_game g
LEFT JOIN levelupapi_gametype t
    ON g.game_type_id = t.id
WHERE t.id = 2
```

### ORM (Game By Type)

The use of the dunderscore (`__`) here represents a join operation. Yes, you did read that right, that was not a typo. Double underscores are used so often that we call it the dunderscore.

```python
game_type_param = self.request.query_params.get('gameTypeId', None)
games = Games.objects.filter(game_type__id=game_type_param)
```

## Get events scheduled by gamer

To retrieve items in the Events table that belong to a specific gamer.

(GET) <http://localhost:8000/profile/events/5k5k5k5k5k5k5k>

### SQL (Events By Organizer)

```sql
SELECT e.id,
       e.description
FROM levelupapi_event e
LEFT JOIN levelupapi_gamer g
    ON e.organizer_id = g.id
WHERE g.uid == "5k5k5k5k5k5k5k";
```

#### ORM (Events By Organizer)

The use of the dunderscore (`__`) here represents a join operation.

```python
events = Event.objects.filter(organizer__uid=uid)
```

## Delete Single Game

(DELETE) <http://localhost:8000/games/5>

### SQL (Delete Single Event)

```sql
DELETE FROM levelupapi_events WHERE id = 5
```

#### ORM (Delete Single Event)

```python
event = Event.objects.get(pk=pk)
event.delete()
```
