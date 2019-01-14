# Introduction to SQL

### Installation of SQLite (if needed)

To get started, type the following command to check if you already have SQLite installed.

```bash
$ sqlite3
```

And you should see:

```
SQLite version 3.7.15.2 2014-08-15 11:53:05
Enter ".help" for instructions
Enter SQL statements terminated with a ";"
sqlite>
```

If you do not see above result, then it means you do not have SQLite installed on your machine. Follow the appropriate instructions below.

#### For Windows

Go to [SQLite Download page](http://www.sqlite.org/download.html) and download the precompiled binaries for your machine. You will need to download `sqlite-shell-win32-*.zip` and `sqlite-dll-win32-*.zip` zipped files.

Create a folder `C:\sqlite` and unzip the files in this folder which will give you `sqlite3.def`, `sqlite3.dll` and `sqlite3.exe` files.

Add `C:\sqlite` to your [PATH environment variable](http://dustindavis.me/update-windows-path-without-rebooting/) and finally go to the command prompt and issue `sqlite3` command.

#### For Mac

First, try to install via Homebrew:

```
brew install sqlite3
```

If not, download the package from above. After downloading the files, follow these steps:

```
$tar -xvzf sqlite-autoconf-3071502.tar.gz
$cd sqlite-autoconf-3071502
$./configure --prefix=/usr/local
$make
$make install
```

#### For Linux

```
sudo apt-get update
sudo apt-get install sqlite3
```

## Setup for Music History Exercise

```sh
mkdir -p ~/workspace/csharp/exercises/music-sql && cd $_
touch queries.sql
```

> **Note:** The `.sql` extension is common practice for files storing SQL queries

## Downloading the Database Files

Download the [musichistory.db](./exercises/assets/musichistory.db) file, and then copy it to the folder that you created for this exercise. That file **is** the database. It contains all of the tables and data.

## Querying Data

Querying the database is how you ask for data that is stored in it. Here's some starter examples.

In the Music History database, there is a list of songs stored in the `Song` table. Here is how you would ask to see all of the rows in that table. You can specify every column in a table.

```sql
SELECT
    SongId,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song;
```

However, if you only need information from a smaller set of columns, you can specify only those.

```sql
SELECT
    SongId,
    Title,
    ReleaseDate
FROM Song;
```

A shortcut that you can use during development (but never in the final production code) is the asterisk - which mean select all columns. The following query is will return that same set of results that the first query above returned.

```sql
SELECT * FROM Song;
```

## Filtering Queries

The `WHERE` clause on a SQL query will filter the results. If you want to find songs that have a duration greater than 100 seconds, you would use the following query.

```sql
SELECT
    SongId,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song
WHERE SongLength > 100
;
```


## Creating New Data

Create a new row in the `Genre` table to represent techno music.

```sql
INSERT INTO Genre (Label) VALUES ('Techno');
```

## Updating Existing Data

Change the length (in seconds) for one of the songs.

```sql
select * from Song where SongId = 18;
> 664

update Song
set SongLength = 515
where SongId = 18;

select * from Song where SongId = 18;
> 515
```

## Deleting Data

You can use the `DELETE` keyword to remove rows from your database tables.

```sql
delete from Song where SongId = 18;
```

Be wary of leaving off the `WHERE` clause. The following SQL statement will remove **ALL ROWS** from the table.

```sql
delete from Song;
```



## References

* [SQLBolt Learn SQL with simple, interactive exercises.](https://sqlbolt.com/)
* [Introductory SQL tutorial](http://www.sqlcourse.com/)
* [W3schools interactive SQL tutorial](https://www.w3schools.com/sql/sql_intro.asp)
* [Online SQLite tutorial](http://www.sqlitetutorial.net/)
