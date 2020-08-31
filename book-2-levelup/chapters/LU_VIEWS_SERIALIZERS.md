# Viewsets and Serializers

These are two key terms that you are going to be introduced to in this chapter. They are the brains of the operation.

The **ViewSet** has all of the logic for handling an incoming request from a client, determining what action is needed _(i.e. create data, get data, update data, or delete data)_, interacting with the database to do what the client asked, and then constructing a response to the client.

The **Serializer** has a much simpler job. Once the ViewSet has determined what kind of response should be sent to the client, if that response has any data, the Serializer converts the Python data into JSON format.

## Workflow Visualization

Any time that you want to allow a client to access data in your database, there's a series of steps you have to follow in order to accomplish it with Django REST Framework.

![](./images/django-rest-process.png)