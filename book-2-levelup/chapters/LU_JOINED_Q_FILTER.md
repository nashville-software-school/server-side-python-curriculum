# Annotate with Two Aggregations

## A Note About Q

The [Q](https://docs.djangoproject.com/en/3.1/topics/db/queries/#complex-lookups-with-q-objects) class in Django is one of the most mysterious and powerful. Many developers have been driven mad trying to understand how to use Q.

At its core, its purpose is simple: to generate AND and OR statements for a WHERE clause in SQL. Unfortunately, its simplicity is wrapped up into a very abstract syntax that requires months of practice to understand.

## Am I Attending?

You can add many virtual properties to objects with the `annotate()` method. In the previous chapter, you added an `attendees` property to all event objects that were created from a Django ORM query.

This makes your code more efficient because you are only making a single query to the database, instead of an additional query for each row in the result set.

In your viewset, you are currently iterating over the entire collection of events in your database, and checking if the current user is attending. If the user is attending, you are setting `joined = True` for that particular event.

Since the current user attending is simply a subset of all gamers that are attending, you can use `Q()` to add that aggregate property on each event with a single SQL statement instead of multiple ones.


```py
events = Event.objects.annotate(
    attendees=Count('registrations'),
    joined=Count(
        'registrations',
        filter=Q(registrations__gamer=gamer)
    )
)
```

In English, you are...

1. Querying the `Event` table
1. Aggregating how many total attendees there are
1. Determining if the current user has joined the event by joining in registrations **AND** filtering by the `gamer` property of each registration.

That will set the value of `joined` to 1 or 0. You want true or false. To get that, add a for loop that converts the numbers to booleans.

```py
for event in events:
    event.joined = bool(event.joined)
```

This is advanced stuff here, but just in case you find a glimmer of understanding in the darkness while reading this chapter, and implementing this code, you may find a use for it in the next group project.

## Challenge: User Events Created

In the game viewset, when the client requests all games, or a single game, the resulting JSON should have a `user_event_count` property on it. If you had completed the previous chapter of adding `event_count` to each game using the `annotate()` method, you need to augment that statement to filter related events down to ones created by the current user.

For example, if a game has an event scheduled, but the event was created by another user, the JSON would look like this.

```json
{
    "id": 3,
    "title": "Catchphrase",
    "maker": "Hasbro Gaming",
    "gamer": {
        "id": 2
    },
    "number_of_players": 6,
    "skill_level": 2,
    "gametype": {
        "id": 1,
        "label": "Table top"
    },
    "event_count": 1,
    "user_event_count": 0
}
```

If the game has 2 scheduled events, and one of them was created by the current user, the JSON should look like this.

```json
{
    "id": 8,
    "title": "Clue",
    "maker": "Milton Bradley",
    "gamer": {
        "id": 3
    },
    "number_of_players": 6,
    "skill_level": 2,
    "gametype": {
        "id": 1,
        "label": "Table top"
    },
    "event_count": 2,
    "user_event_count": 1
}
```
