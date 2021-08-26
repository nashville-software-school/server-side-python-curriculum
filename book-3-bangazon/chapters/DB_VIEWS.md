# Database Views

Views are SQL statements that are stored in the database itself. Nothing more.

Many companies have multiple applications that all query the same database. If the developers find that multiple applications all have the exact same SQL queries in them, that query can be changed into a view, and the applications simply query that view.

Here's an example.

In the Games by User report, you have the following SQL code in the Django report module.

```sql
SELECT
    g.id,
    g.title,
    g.maker,
    g.game_type_id,
    g.number_of_players,
    g.skill_level,
    u.id user_id,
    u.first_name || ' ' || u.last_name AS full_name
FROM
    levelupapi_game g
JOIN
    levelupapi_gamer gr ON g.gamer_id = gr.id
JOIN
    auth_user u ON gr.user_id = u.id
```

As you are building out more features of the Django REST API application, you realize that you need that exact query. You have two options.

1. Copy pasta the SQL into one the API ViewSets.

    ***OR***

1. Create a database view and have the API application and the reporting application both query the view.

You decide to make a view.

## Creating Views

If you haven't created a SQL file for LevelUp yet, do that now.

Open your LevelUp SQL file. This is where you'll create the view.

Put `CREATE VIEW [view_name] AS` followed by your SQL statement as shown below.

Execute it to create the view, and add it to the database.

> ##### `levelup-server/levelup.sql`

```sql
CREATE VIEW GAMES_BY_USER AS
SELECT
    g.id,
    g.title,
    g.maker,
    g.game_type_id,
    g.number_of_players,
    g.skill_level,
    u.id user_id,
    u.first_name || ' ' || u.last_name AS full_name
FROM
    levelupapi_game g
JOIN
    levelupapi_gamer gr ON g.gamer_id = gr.id
JOIN
    auth_user u ON gr.user_id = u.id
;
```

## Querying Views

Now open the `levelupreports/views/users/gamesbyuser.py` module and replace the SQL statement in there with the following one.

```sql
SELECT
    *
FROM
    GAMES_BY_USER
```

You will get back the exact same data because the database will run the original SQL for you and return it.

## Practice: Events by User

1. Take the SQL that you wrote for the Events by User report and save it to the database as a view.

1. Then update the Django report module to query the view instead.

1. Verify that you report still generates the correct HTML.
