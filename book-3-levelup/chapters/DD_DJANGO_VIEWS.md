# Your First View

Views are where the logic, or brains, of your application lives. Up to this point, all that logic of what should happen when a client makes a request to your API happened in the `request_handler.py` module.

In a Django application, you are going to break all of that up into separate views. Each view will define what should happen for a single resource.

For now, open the `deshawnapi/views/city_view.py` module and take a look at the **`CityView`** class. Yours will have comments in it, but those have been stripped away for this chapter overview.

This view will handle client requests for cities. 

1. The `retrieve` method handles requests for a single city.
2. The `list` method handles requests for all cities.

```py
class CityView(ViewSet):

    def retrieve(self, request, pk=None):
        city = City.objects.get(pk=pk)
        serialized = CitySerializer(city, context={'request': request})
        return Response(serialized.data, status=status.HTTP_200_OK)

    def list(self, request):
        cities = City.objects.all()
        serialized = CitySerializer(cities, many=True)
        return Response(serialized.data, status=status.HTTP_200_OK)

```

Start your server if it is not already running (F5), open Postman to test these calls

|Request Method|URL|View Method Executed|
|--|--|--|
|GET|http://localhost:8000/cities/1|retrieve|
|GET|http://localhost:8000/cities|list|

Each view method is going to follow the same logical pattern. As you get more experience with Django, the logic will get more sophisticated, but the overall pattern will remain the same.

1. Interact with the database using the corresponding database model.
2. If data is needed for the response, define how the JSON should be structured with a Serializer.
3. Return a `Response` instance. Specify the response body and the status code as arguments.

## Appointments View

For the time being, the view for appointments will support the operations of getting all, getting single, and creating appointments. Therefore, it will define the following methods.

In this section, we will be adding the beginnings of the code needed to create a new view.

* `retrieve()`
* `list()`
* `create()`

|Request Method|URL|View Method Executed|
|--|--|--|
|GET|http://localhost:8000/appointments/1|retrieve|
|GET|http://localhost:8000/appointments|list|
|POST|http://localhost:8000/appointments|create|

## **TODO:** Create the Appointments View
The code is below and you can see that it is very similar to the cities view, yet with a new method that has been commented for your pleasure.

> ##### `views/appointment_view.py`

```py
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from deshawnapi.models import Appointment, Walker


class AppointmentView(ViewSet):

    def retrieve(self, request, pk=None):
        appointment = Appointment.objects.get(pk=pk)
        serialized = AppointmentSerializer(appointment, context={'request': request})
        return Response(serialized.data, status=status.HTTP_200_OK)

    def list(self, request):
        appointments = Appointment.objects.all()
        serialized = AppointmentSerializer(appointments, many=True)
        return Response(serialized.data, status=status.HTTP_200_OK)

    def create(self, request):
        # Get the related walker from the database using the request body value
        client_walker_id = request.data["walkerId"]
        walker_instance = Walker.objects.get(pk=client_walker_id)

        # Create a new appointment instance
        appointment = Appointment()

        # Use Walker instance as the value of the model property
        appointment.walker = walker_instance

        # Assign the appointment date using the request body value
        appointment.date = request.data["appointmentDate"]

        # Performs the INSERT statement into the deshawnapi_appontment table
        appointment.save()

        # Serialization will be covered in the next chapter
        serialized = AppointmentSerializer(appointment, many=False)

        # Respond with the newly created appointment in JSON format with a 201 status code
        return Response(serialized.data, status=status.HTTP_201_CREATED)


# The serializer will be covered in the next chapter
class AppointmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Appointment
        fields = ('id', 'walker', 'date',)

```

## TODO: Update Views Package

Open the `views/__init__.py` module and add your new class to the package.

```py
from .appointment_view import AppointmentView
```

## Next Steps

You are one step closer to performing your first database migration so that the `deshawnapi_appointment` table will be created in your database. However, you need to do two more things first.

In the next chapter, you will explore what a serializer is in the Django framework and how it is used to generate JSON.
