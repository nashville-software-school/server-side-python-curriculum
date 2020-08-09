# Getting Animals With Embedded Locations

## Videos to Watch First

* [SQL Joins Explained |¦| Joins in SQL |¦| SQL Tutorial](https://www.youtube.com/watch?v=9yeOJ0ZMUYw&t=33s)
* []()
* []()
* []()
* []()

## Joining Data for Python Kennel

Right now, you can get all locations, and get all animals from your client and then use JavaScript to "join" them together.

```js
const animals = useAnimals()
const locations = useLocations()

const animalsWithLocation = animals.map(animal => {
    animal.location = locations.find(location => {
        return location.id === animal.location_id
    })
})
```

This process requires two `fetch()` calls to the API and plenty of iterations to get the information together to generate the final HTML representations you want.

What if you could let the server do the joining of the data? That way, you only need one call to the API and reduce the processing needs of the client.

#### Goal: Animal Representation with Embedded Location

```json
 {
    "id": 6,
    "name": "Daps",
    "species": "Kennel",
    "status": "Boxer",
    "location_id": 2,
    "customer_id": 2,
    "location": {
        "name": "Nashville South",
        "address": "101 Penn Ave"
    }
}
```

## Joining Tables in SQL

The video showed you how to join 2 tables to ensure that only information that had a match in the other one were returned.

It showed `INNER JOIN`.

In most dialects of SQL, you can discard the `INNER` and it will be assumed. You will use the shortened syntax in this application.

In the query below, you start with selecting the `Animal` table and specify which fields you want. One field is `location_id`, but that's not enough. Remember, the goal is to have the location name and address embedded in the response.

Now you can join the `Location` table into the query so that the name and address fields

```sql
SELECT
    a.id,
    a.name,
    a.breed,
    a.status,
    a.location_id,
    a.customer_id,
    l.name location_name,
    l.address location_address
FROM Animal a
JOIN Location l
    ON l.id = a.location_id
```

|id|name|breed|status|location_id|customer_id|location_name|location_address|
|--|--|--|--|--|--|--|--|
1|	<span style="color:red">Snickers</span>|	Recreation|	Dalmation|	1|	4|	Nashville North|	64 Washington Heights	|
2|	Jax|	Recovery|	Beagle|	1|	1|	Nashville North|	64 Washington Heights	|
3|	Falafel|	Treatment|	Siamese|	2|	4|	Nashville South|	101 Penn Ave	|
4|	Doodles|	Kennel|	Poodle|	1|	3|	Nashville North|	64 Washington Heights	|
6|	Daps|	Kennel|	Boxer|	2|	2|	Nashville South|	101 Penn Ave|