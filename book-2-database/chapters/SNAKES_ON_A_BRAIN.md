# Snakes On A Brain

Your job is to build a snake API, also known as a Snake PI, that lets developers build browser applications with our data.

> "We need to get all these slithering snakes off my slimy brain"

## Learning Objectives You Will Self-Assess

1. Basic Vanilla Python syntax
   1. if
   2. for
   3. function
   4. modules
   5. packages
   6. import
   7. lists
   8. dictionaries
1. SQL
   1. SELECT single
   2. SELECT multiple with JOIN
   3. Filter with WHERE

## Requirements

We strongly urge you to read all of these requirements carefully before you begin coding. We also want to see your ERD as part of your vocabulary review session so that your vocab about data relationships and SQL is solid.


---

**Given** a client wants to view all species<br/>
**When** a client makes a GET request to the `/species` endpoint for your API<br/>
**Then** the client should receive a list of dictionaries in the response body. Each dictionary contains all properties of species.<br/>
**And** the status code should be 200

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/species | List |


---

**Given** a client wants to view a single species<br/>
**When** a client makes a GET request to the `/species/{id}` endpoint for your API<br/>
**Then** the client should receive a dictionary in the response body.<br/>
**And** the status code should be 200

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/species/3 | Dictionary |


---

**Given** a client wants some data that your API doesn't support<br/>
**When** the client makes a GET, POST, PUT, or DELETE request to any other endpoint<br/>
**Then** the client should receive a blank request body<br/>
**And** the status code should be 404

| Method | URL | Status Code |
|--|--|--|
| GET | http://localhost:8088/snakefood | 404 |
| PUT | http://localhost:8088/habitats/4 | 404 |
| DELETE | http://localhost:8088/petstore/1 | 404 |
| POST | http://localhost:8088/cleaners | 404 |

---

**Given** a client wants to view all snakes<br/>
**When** the client makes a GET request to `/snakes`<br/>
**Then** the client should receive a list of dictionaries for all snakes<br/>
**And** the status code should be 200

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/snakes | List |

---

**Given** a client wants to view all snakes of a certain species<br/>
**When** the client makes a GET request to `/snakes` with a query string parameter of `species` that has a valid species primary key<br/>
**Then** the client should receive a list of dictionaries for all snakes of that species<br/>
**And** the status code should be 200

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/snakes?species=1 | List |

---

**Given** a client wants to view the details of a single snake<br/>
**When** the client makes a GET request to `/snakes/{id}`<br/>
**Then** the client should received a dictionary representation of the snake in the response body<br/>
**And** the status code should be 200<br/>
**Unless** the species of the snake is "Aonyx cinerea" since these snakes always live in colonies and are never found solo in the wild. A status code of 405 should be used in this case.<br/>

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/snakes/13 | Dictionary |

---

**Given** the client wants to create a snake<br/>
**When** the client send a POST request to `/snakes`<br/>
**And** the client includes all required properties in the request body<br/>
**Then** the client should receive dictionary in the response body<br/>
**And** the response status code should 201<br/>

| Method | URL | Response Body |
|--|--|--|
| POST | http://localhost:8088/snakes | Dictionary |

---

**Given** the client wants to create a snake<br/>
**When** the client send a POST request to `/snakes`<br/>
**And** the client **does not** include all required properties in the request body<br/>
**Then** the client should receive a message in the response body detailing the missing properties<br/>
**And** the response status code should 400<br/>

| Method | URL | Response Body |
|--|--|--|
| POST | http://localhost:8088/snakes | Dictionary |

---

**Given** a client wants to view all owners<br/>
**When** the client makes a GET request to `/owners`<br/>
**Then** the client should receive a list of dictionaries for all owners<br/>
**And** the status code should be 200

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/owners | List |

---

**Given** a client wants to view the details of a single owner<br/>
**When** the client makes a GET request to `/owners/{id}`<br/>
**Then** the client should received a dictionary representation of the owner in the response body<br/>
**And** the status code should be 200<br/>

| Method | URL | Response Body |
|--|--|--|
| GET | http://localhost:8088/owners/4 | Dictionary |


# Data

Expand the sections below to create the required tables for your database and insert some starter data.

<details>
   <summary>Species</summary>

```sql
create table Species (
	id INT,
	name VARCHAR(50)
);
insert into Species (id, name) values (1, 'Procyon cancrivorus');
insert into Species (id, name) values (2, 'Aonyx cinerea');
insert into Species (id, name) values (3, 'Pitangus sulphuratus');
insert into Species (id, name) values (4, 'Nannopterum harrisi');
insert into Species (id, name) values (5, 'Tamiasciurus hudsonicus');
```
</details>

<details>
   <summary>Owners</summary>

```sql
create table Owners (
	id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50)
);
insert into Owners (id, first_name, last_name, email) values (1, 'Jarrett', 'Thunder', 'jthunder0@amazon.de');
insert into Owners (id, first_name, last_name, email) values (2, 'Charline', 'Manton', 'cmanton1@china.com.cn');
insert into Owners (id, first_name, last_name, email) values (3, 'Lura', 'Cornbell', 'lcornbell2@ning.com');
insert into Owners (id, first_name, last_name, email) values (4, 'Bo', 'Pearn', 'bpearn3@hp.com');
insert into Owners (id, first_name, last_name, email) values (5, 'Veronike', 'Hellings', 'vhellings4@utexas.edu');
insert into Owners (id, first_name, last_name, email) values (6, 'Yule', 'Tilmouth', 'ytilmouth5@nps.gov');
insert into Owners (id, first_name, last_name, email) values (7, 'Agata', 'Vasilmanov', 'avasilmanov6@fema.gov');
insert into Owners (id, first_name, last_name, email) values (8, 'Irvin', 'Folshom', 'ifolshom7@mapquest.com');
insert into Owners (id, first_name, last_name, email) values (9, 'Jeanna', 'Dyas', 'jdyas8@amazon.co.uk');
insert into Owners (id, first_name, last_name, email) values (10, 'Ulick', 'Drinkhill', 'udrinkhill9@wsj.com');
```
</details>

<details>
   <summary>Snakes</summary>

```sql
create table Snakes (
	id INT,
	name VARCHAR(50),
	owner_id INT,
	species_id INT,
	gender VARCHAR(50),
	color VARCHAR(50)
);
insert into Snakes (id, name, owner_id, species_id, gender, color) values (1, 'Annotée', 2, 2, 'Female', 'Turquoise');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (2, 'Lorène', 1, 1, 'Male', 'Green');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (3, 'Alizée', 8, 1, 'Female', 'Blue');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (4, 'Océane', 7, 1, 'Male', 'Khaki');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (5, 'Almérinda', 4, 4, 'Male', 'Yellow');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (6, 'Athéna', 3, 5, 'Female', 'Violet');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (7, 'Bénédicte', 8, 2, 'Male', 'Mauv');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (8, 'Solène', 2, 3, 'Male', 'Yellow');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (9, 'Aí', 6, 4, 'Female', 'Goldenrod');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (10, 'Andréa', 9, 5, 'Male', 'Turquoise');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (11, 'Noémie', 6, 2, 'Male', 'Crimson');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (12, 'Gwenaëlle', 4, 1, 'Male', 'Puce');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (13, 'Océane', 9, 5, 'Male', 'Turquoise');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (14, 'Bérengère', 5, 2, 'Female', 'Turquoise');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (15, 'Lyséa', 7, 2, 'Male', 'Fuscia');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (16, 'Méghane', 1, 2, 'Male', 'Crimson');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (17, 'Léonore', 5, 1, 'Female', 'Yellow');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (18, 'Anaël', 6, 5, 'Female', 'Puce');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (19, 'Nélie', 7, 1, 'Female', 'Pink');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (20, 'Béatrice', 9, 1, 'Female', 'Green');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (21, 'Gösta', 5, 2, 'Female', 'Mauv');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (22, 'Clélia', 5, 3, 'Male', 'Purple');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (23, 'Méng', 2, 5, 'Female', 'Khaki');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (24, 'Angélique', 2, 1, 'Female', 'Mauv');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (25, 'Aimée', 10, 2, 'Female', 'Pink');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (26, 'Marie-françoise', 2, 1, 'Female', 'Green');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (27, 'Tán', 4, 2, 'Female', 'Teal');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (28, 'Andréanne', 5, 4, 'Female', 'Green');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (29, 'Stéphanie', 8, 5, 'Female', 'Purple');
insert into Snakes (id, name, owner_id, species_id, gender, color) values (30, 'Liè', 7, 1, 'Female', 'Maroon');
```
</details>
