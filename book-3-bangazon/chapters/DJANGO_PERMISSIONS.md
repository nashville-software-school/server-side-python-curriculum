


# What are permissions?
In Django, permissions are how to give users granular access to endpoints. While it's easier to make a user a staff or admin user, if they don't need access to everything that comes with those it can create a security issue later. [Here](https://www.beyondtrust.com/blog/entry/what-is-least-privilege)'s a good resource on why limiting permissions is integral to security whether it's a website, application, or server.

Permissions are automatically created by django for each model. There's a permission for each CRUD method. Permissions are stored in the `auth_permission` table in the database. There is also a way to create custom permissions, found [here](https://docs.djangoproject.com/en/3.1/topics/auth/customizing/#custom-permissions).

While we could associate one or more permissions directly with a user, if you want to reuse that set of permissions it makes more sense to create a `group` in django and add permissions to that group.

## Creating Groups

First we'll create a Player group in the django admin. If you haven't run `python3 manage.py createsuperuser` do that now. Next log into the django admin portal at `/admin` with the superuser. If you get a `Page not found` error add `path('admin/', admin.site.urls),` to your project's `urls.py urlpatterns` list.

After logging in, click on groups and add a Players group. This group should be able to view games, events, and game types but should not be able to edit, create or delete them. They should also be able to join events.
These are the permissions we'll add to the group:

```
levelupapi | event | Can view event
levelupapi | game | Can view game
levelupapi | gamer event | Can add gamer event
levelupapi | gamer event | Can change gamer event
levelupapi | gamer event | Can delete gamer event
levelupapi | gamer event | Can view gamer event
```
![Adding permission to group](./images/player_permissions.gif)

To add a group to a user, click on `Users` and select a user that is not the superuser. Scroll to permissions and there will be a groups selector. Add the `Players` group and save.


# Try it out:
Add a `Host` group. They should be able to create, view, update, and delete: games, events, and gamer events. Add the group to a different user.
