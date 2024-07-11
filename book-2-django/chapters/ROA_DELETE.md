# Deleting Rocks

Delete is arguably the simplest operation to perform with the Django ORM. First, you need to implement the **destroy** method in your Django view.

1. Open the `views/template.py` module and copy the **destroy** method.
2. Paste that method into your rock view.
3. Change the variable names and models to be appropriate to deleting rocks instead of **Void**.
4. Make sure the debugger restarts.

Now you can go to Postman, or whichever API client you are using, and perform the following request. Make sure you have the **Authorization** header set.

| Method | URL | Response Data | Status Code |
|--|--|--|--|
| DELETE | http://localhost:8000/rocks/1 |  | 204 |

## Only Delete Your Own Rocks

Once you have verified that DELETE requests work, the next step is to ensure that only the creator of the rock can delete it. You don't want users to be allowed to delete the rocks in other users' collections.

Remember the `request.auth.user` object that Django automatically provides to allow you to know who is authenticated in the client? Probably not, so you're going to practice using it again.

Before you invoke the `.delete()` method on a Rock instance, you want to make sure that the authenticated user owns it. The good news is that the check is pretty easy with Django.

The **Rock** model has a `user` field on it.

Django makes `request.auth.user` available automatically when there is an **Authorization** header on the request from the client.

You just need to make sure those are equal before you do the delete method. If the user is the owner, perform the delete and return the 204 status code. If the user is not the owner, do nothing with the data and return a response with a 403 status code.

> A 403 status is for when the client is properly authenticated, but is forbidden from accessing the specific resource that was requested.

```py
# Verify that the pk of the rock owner is the same pk as the authenticated user
if rock.user.id == request.auth.user.id:
   rock.delete()
   return Response(None, status=status.HTTP_204_NO_CONTENT)
else:
   return Response({'message': 'You do not own that rock'}, status=status.HTTP_403_FORBIDDEN)
```

Now try to delete a rock that is not owned by the user assigned to the token you specified in the **Authorization** header. If all rocks in your database are owned by the same person, just make sure you have more than one user, and then use another person's token in the DELETE request.

Verify that you can still delete the rocks assigned to the user assigned to your token, and that you get a 403 status code when you try to delete another user's rock.
