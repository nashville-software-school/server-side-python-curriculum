# Supp Ch.3 Enforcing Permissions

Now that we've added permissions to users we need to tell django how we want to use them.

There are three base types of permissions.

1. Auth based (Is the user authenticated?)
2. Model based (Can the user access this CRUD method on this model?)
3. Object based (Can the user access this CRUD method on this model instance?)
   - Useful for checking if a user can edit their own event submission but not other events

Currently, the project is using auth based permissions for all routes. That is being set in the `settings.py` file

![default permissions](./images/default_permissions.png)

This is saying for every route, as long as the user is authenticated they can have access to that method.

Before moving on, read about the different types of permission checks that Django offers: https://www.django-rest-framework.org/api-guide/permissions/#api-reference

While we could change the default permission for every route, we can also change the permission per view. To do this, we'll open the `GameViewSet` and before the CRUD functions add:

```py
permission_classes = [ DjangoModelPermissions ]
queryset = Game.objects.none()
```

The `permission_classes` tells django which permission type to use. Since permissions are tied to the model, we need to add a `queryset` property so the view knows about the model and permissions.

Using Postman try to get all games as a player user. That should work. Now try to update a game. What happens?

![Denied](https://media.giphy.com/media/OgbPFB5AE3jW/giphy.gif)

Try again as a `Host` user.

# Try it out

Create a custom permission that checks if a user created a game or event before allowing them to edit or delete.
Resources:
https://www.django-rest-framework.org/api-guide/permissions/#custom-permissions
