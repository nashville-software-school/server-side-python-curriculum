# Karen's Level Up Requirements

## Meeting Karen

> Karen is sitting at the table by the front window of the Cat Café where she wanted to meet and discuss the "program" she wants you to write for her. She smiles thinly as you enter, making the tiny bell above the door ring.
>
> She has a grey cat sitting in her lap, which she gently holds in one arm as she stands and offers her limp hand for you to try to shake.
>
> You grab her hand awkwardly and quickly release it and say, "It's a pleasure to meet you, Karen. What a lovely cat!"
>
> She sits again and puts the cat back in her lap, and replies, "I'm glad to meet you, too. This is Gentry. He needed some attention this morning, so I decided to bring him with me." She starts to slowly stroke his back and tail with her hand.
>
> You eagerly say, "I'm excited to hear what you want me to build for you. I enjoy playing games, too. Mostly video games."
>
> Karen grimaces slightly, but quickly recovers, and says, "Yes, I'm sure you do. What I'm looking for is a way to meet people like me who play card games and board games, like me."
>
> "My cat, Sheen," she continues, "likes to play games with me, but nothing quite as complex as Settlers of Catan or Bridge." Her face brightens a bit as she talks about how she tries to get her cats to play games with her.
>
> "One time, I even put catnip on some checkers and tried to see if Checkers - that's one of my cats, Checkers - could move the piece to play with me. It didn't really work." She laughs lightly, obviously playing the scenario out in her mind.
>
> You force a small laugh to play along, and ask, "Can you tell me what you're looking for in the application you want me to build for you?"
>
> "Of course, dear!"
>
> You take your pen out and open your notebook ready to furiously scribble notes.
>
> "I want a way to schedule events for people to play games."
>
> You make a quick note, and then look up at her expectantly, waiting for more information.
>
> Karen smiles a bit, and blinks, obviously thinking she gave you all the information you need.
>
> "Um, ok. Well... what games can people make events for? Any game?"
>
> "I was thinking card games, and board games," she replies.
>
> You press on with, "But any one of those games, right?"
>
> "Well, of course, dear. I'm not against learning a new game. As long as I'm meeting people and having fun. As my cat Bumble once told me, 'Life is but a game', and I agree."
>
> It's becoming clear that Karen spends a little too much time with her cats.
>
> "Ok, so people can create any game they want. Got it. So... who schedules an event? The person who creates the game, or anyone who wants to play the game?"
>
> Karen looks to the side for a moment to think and replies, "I think anyone should be able to schedule an event for any game that has been added."
>
> You write more notes.
>
> "Oh!" she exclaims quickly, "and I want people to say if they are coming. That way the woman holding the event knows how many people to expect. It's only proper."
>
> You ask, "And anyone can sign up for any event?"
>
> "The more the merrier, dear." She looks down at Gentry, and continues, "Just like with my cats. The more the merrier."
>
> You finish writing your notes, smile, and say, "I think I have all I need to get an initial version for you to see and give me feedback. It was so lovely to meet you, Karen."
>
> She stands again with Gentry, and replies, "Likewise, and you can call me Kari. My son has told me about the "Karen" memory going around the internet. I don't want people to think I'm a Karen."
>
> _"Did she mean meme?"_ you think to yourself.
>
> You force yourself to keep a straight face and reply, "Very well, Kari. I'll let you know when I'm done with the first version and we can schedule a time to meet again."
>
> You leave the Cat Café thinking that you just had one of the weirdest experiences of your life.


## Create ERD

Your task is to take the requirements from Karen and build an ERD on dbdiagram.io that visualizes the tables and relationships for the system that she wants you to build.

## Design Models

Now that the application has been configured correctly, it's time to start designing your database. In Django, you use model classes instead of writing `CREATE TABLE` SQL statements.

Here is a quick example.

Imagine that you want to create a table in your database to store information about toys. These toys have a few properties.

* Color
* Price
* Material
* Name

In SQL, you would write the following SQL statement to create the table.

```sql
CREATE TABLE `Toy` (
	`id`	    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	    TEXT NOT NULL,
	`material`	TEXT NOT NULL
	`color` 	TEXT NOT NULL
	`price` 	FLOAT NOT NULL
);
```

Django can do that for you without ever needing to write SQL. You write classes that act as database models. You even get to leave out the `id` field. Django will add that automatically.

```py
from django.db import models

class Toy(models.Model):
    name = models.CharField(max_length=55)
    material = models.CharField(max_length=55)
    color = models.CharField(max_length=12)
    price = models.DecimalField(max_length=7,decimal_places=2)
```

## Application User (Gamer) Model

Django gives you a **`User`** model out of the box with fields like first name, last name, email, etc. already on it. If there additional fields that you want to capture about a user of your application, you need to create a separate model.

In this application, you are going to ask each gamer to provide a short bio when they register. The Django user model does not have a `bio` field, so you need to create a **`Gamer`** model with that field on it, and it should have a 1 to 1 relationship with a corresponding user entry.

> #### `levelup/levelupapi/models/gamer.py`

```py
from django.db import models
from django.contrib.auth.models import User


class Gamer(models.Model):

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bio = models.CharField(max_length=50)
```

Then create a package initialization module and import your gamer model into it. Every model you create must be imported into this package init module.

> #### `levelup/levelupapi/models/__init__.py`

```py
from .gamer import Gamer
```

## Level Up Models

Once you have a good ERD that defines the tables and relationships for gamers, games, and events, create your modules and classes and import the classes into the package init module.

## Migration of Models

Once you have defined your models, you should review them with an instructor.

When your models are approved, you can then run a migration to get the tables created in your database.

```sh
python manage.py makemigrations levelupapi
```
