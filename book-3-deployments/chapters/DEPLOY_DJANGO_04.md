# Step 4: Creating Digital Ocean App

## Generate requirements file

Only if you are using Poetry to create and manage your virtual environment, you need to run the following command to generate a dependencies file that Digital Ocean supports. If you used `pipenv` then you can skip this step.

```bash
poetry export --format=requirements.txt > requirements.txt
```

## Generate App

First, if you haven't used Digital Ocean yet, [sign up for $100 credit](https://m.do.co/c/47e5e578d1cd) which is good for 60 days.

> Reminder: Deploying your Django app is $5.00 per month after your initial credit is used, or after 60 days has passed.

Visit https://cloud.digitalocean.com/apps and click **Create App**.

You’ll be prompted to connect your GitHub account. Connect your account and allow DigitalOcean to access your repositories. You can then choose to let DigitalOcean have access to all of your repositories or just to the ones you wish to deploy.

Click **Install and Authorize** to return to your DigitalOcean dashboard and continue creating your app.

Under the **Repository** section, choose your project repository from the dropdown menu. Select your `main` branch. Do not enable autoscaling.

Then, click **Next**.

### Custom run command

DigitalOcean detects that your project is a Python app and automatically populates a partial run command. You will see a summary page named **Review and configure resource settings**.

1. Scroll down to the **Deployment settings** section.
2. Click the **Edit** link in that section.
3. Recall that the name of your project is the directory name where `urls.py` and `settings.py` are, not where your models, views, fixtures are. Replace `django_app` in the command below with your project name.
    ```sh
    python manage.py makemigrations {name of your api project}
    python manage.py migrate
    gunicorn --worker-tmp-dir /dev/shm django_app.wsgi
    ```
4. Then click the **Close** link in that section

### Changing resource size

1. Click **Edit** link in the **Size** section.
2. Choose the smaller amount in the dropdown _(usually $5.00/mo)_
3. CLick the **Close** link to save selection.

Go to the next chapter to continue configuring your project.

[Go to Step 5 >](./DEPLOY_DJANGO_05.md)

