# Serialization

Serialization is an important concept to understand as a software developer. Especially for a web application developer as you are constantly serialzing data structure to strings, and then from strings back to data structures.

| Term | Definition |
| --| --|
| Serialization | The process of converting a data structure into a format that can be stored or transmitted _(e.g. over the WWW)_ and reconstructed later. When the information is retrieved later using the same formatting mechanism, the original object is created again for use by your code. |

## Serializing a City Instance

Remember that you can only transmit strings across the WWW. When you create an instance of a City class, it is ephemeral and complex - a large collection of properties, methods, and memory addresses. You need a way to simplify it into a straightforward JSON representation.

**That's the job of the serializer.**

Look in the `city_view.py` module to see an existing serializer. It's amazingly sparse code for what is actually being done by it.

* It has a sub-class named Meta
* You specify which database model you want to use
* You specify which fields in the model should be in the final JSON string.

```py
class CitySerializer(serializers.ModelSerializer):

    class Meta:
        model = City
        fields = ('id', 'name',)
```
The above Serializer will produce the following as a response on this endpoint `http://localhost:8000/cities/2`:

```json
{
    "id": 2,
    "name": "White Plains"
}
```

Then, in your view, you can use the serializer to generate JSON from class instances. You pass it two arguments.

1. The data structure to be serialized into JSON.
2. Set `many` to true if you are serializing a list, or set it to false if serializing a single instance.

```py
# To serialize a list of cities (multiple rows)
cities = City.objects.all()
serialized = CitySerializer(cities, many=True)

# To serialize a single city (1 row)
city = City.objects.get(pk=pk)
serialized = CitySerializer(city, many=False)
```

## Serializing Appointments

You already have a serializer for appointments. You will notice that the `completed` field from the appointment model is not included in the fields to be serialized. This will generate JSON responses that look like this.

```json
{
   "id": 1,
   "walker": 2,
   "date": "2022-10-17"
}
 ```

The `completed` field will be completely ignored during the serialization process.

## Next Steps

In the next chapter, you will configure your API to respond to client requests to http://localhost:8000/appointments.
