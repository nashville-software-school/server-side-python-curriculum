steps:
1. install heroku cli
1. Create heroku account
2. create application in heroku
3. connect heroku app to git
4. pipenv install gunicorn django_on_heroku
5. add to settings.py
```py 
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = "/static/"

django_on_heroku.settings(locals())
```
4. add procfile
1. add and commit changes
1. `git push heroku main`
1. `heroku open` should see base rest framework unauthorized page
1. The next step is checking that a database was created. Run `heroku pg` and you should see something like this: 
![heroku pg output](./images/heroku_pg_output.png)
1. Can't have a django project without tables so run `heroku run python manage.py migrate` The output should look similar to running it locally
1. You'll need to create your django superuser next `heroku run python manage.py createsuperuser` This is a live site so make sure to use a strong password
1. You should notice that all the normal `python manage.py .....` commands work as long as `heroku run` is at the beginning of the command. 
1. Now to load the fixture data onto your database. **DO NOT LOAD the users.json OR tokens.json!!!!!!!** There is the superuser with an id of 1 so the rest of your fixtures will still work
1. To create a token for the superuser log into `<your-url>.com/admin` with the superuser and click on `Tokens` on the left and add a token for the superuser.

### Using Postman

At this point you should be able to use postman to get data from the database. 

Copy the token key you just created and add it to the postman headers:
![postman example headers](./images/postman_ex.png)

Copy the url heroku gave you into the url bar and try it out!


### Front end Deployment
Good news! Whatever you used to deploy during the front end will still work. You'll just need to update your api calls in react to use the deployed url 
