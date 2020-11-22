# Annotate with Two Aggregations

## A Note About Q

The [Q](https://docs.djangoproject.com/en/3.1/topics/db/queries/#complex-lookups-with-q-objects) class in Django is one of the most mysterious and powerful. Many developers have been driven mad trying to understand how to use Q.

At its core, its purpose is simple: to generate AND and OR statements for a WHERE clause in SQL. Unfortunately, its simplicity is wrapped up into a very abstract syntax that requires months of practice to understand.

## Am I Attending?

You can add as many virtual properties to objects with the `annotate()` method. In the previous chapter, you added an `attendees` property to all event objects that were created from a Django ORM query.

This makes your code more efficient because you are only making a single query to the database, instead of an additional query for each row in the result set.

In your viewset, you are currently iterating over the entire collection of events in your database, and checking if the current user is attending. If the user is attending, you are setting `joined = True` for that particular event.

Since the current user attending is simply a subset of all gamers that are attending, you can use `annotate()` to add that aggregate property on each event with a single SQL statement instead of multiple ones.


```py
events = Event.objects.annotate(
    attendees=Count('registrations'),
    joined=Count(
        'registrations',
        filter=Q(registrations__gamer=gamer)
    )
)
```

That will set the value of `joined` to 1 or 0. You want true or false. To get that, add a for loop that converts the numbers to booleans.

```py
for event in events:
    event.joined = bool(event.joined)
```

This is advanced stuff here, but just in case you find a glimmer of understanding in the darkness while reading this chapter, and implementing this code, you may find a use for it in the next group project.