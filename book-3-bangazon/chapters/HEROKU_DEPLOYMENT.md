# Deploying with Heroku
Heroku is a cloud platform that lets companies build, deliver, monitor and scale apps. It's pretty simple to use for deploying your django application. Best of all, there's a free tier that will be powerful enough for what you'll need.

### Steps
1. Install heroku cli: https://devcenter.heroku.com/articles/getting-started-with-python#set-up
1. Create heroku account. You will want to use two factor authentication (TFA) when creating your account: https://signup.heroku.com/
2. Create application in heroku: https://dashboard.heroku.com/new-app
3. After you create the application, it should have some cli commands for you to run to connect your code to the application
4. There's a few extra packages you'll need to install `pipenv install gunicorn django_on_heroku`
5. At the beginning of the `settings.py` around line 22 there are some Security warnings:
    1. If you have not already hidden your secret key: 
    2. For the `SECRET_KEY` warning: change the line to `SECRET_KEY = os.getenv('SECRET_KEY')`
    3. Then copy the terminal output of this command `python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'`
    4. Create a new file called `.env` and add `export SECRET_KEY=<paste output>`.
    5. This creates an environment variable that gets created when the pipenv shell is started. Using `os.getenv('SECRET_KEY)` gets that env variable of that name to use in the django app
    6. For the debug security warning, make sure to set `DEBUG` to `False` once you're done testing your api
7. Add some lines to end of `settings.py`
```py
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = "/static/"
STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.StaticFilesStorage'

django_on_heroku.settings(locals())
```
4. Add a file called `Procfile` and paste in this line (change out `levelup` for your project module name) `web: gunicorn levelup.wsgi --log-file -`
1. Add and commit all the changes
1. To add code to the heroku server run: `git push heroku main`
1. Run `heroku open` and you should see the base rest framework unauthorized page
1. The next step is checking that a database was created. Run `heroku pg` and you should see something like this:
![heroku pg output](./images/heroku_pg_output.png)
1. Can't have a django project without tables so run `heroku run python3 manage.py migrate` The output should look similar to running it locally
1. You'll need to create your django superuser next `heroku run python3 manage.py createsuperuser` This is a live site so make sure to use a strong password
1. You should notice that all the normal `python3 manage.py .....` commands work as long as `heroku run` is at the beginning of the command.
1. Now to load the fixture data onto your database. **DO NOT LOAD the users.json OR tokens.json!!!!!!!** There is the superuser with an id of 1 so the rest of your fixtures will still work
1. To create a token for the superuser log into `<your-url>.com/admin` with the superuser and click on `Tokens` on the left and add a token for the superuser.

### Using Postman

At this point you should be able to use Postman to get data from the database.

Copy the token key you just created and add it to the Postman headers:
![postman example headers](./images/postman_ex.png)

Copy the URL heroku gave you into the URL bar and try it out!


### Front end Deployment
Good news! Whatever you used to deploy during the front end will still work. You'll just need to update your API calls in react to use the deployed URL
