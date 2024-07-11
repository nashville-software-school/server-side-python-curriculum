# Deploy API To AWS

Elasstic Beanstalk is a managed service provided by Amazon that eases the deployment of an application.

## Prerequisites

Sign up for [free tier AWS account](https://aws.amazon.com/free/)

## Using Elastic Beanstalk

The first step is to [install the command line tool for Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html).

Then read the [Deploying a Django application to Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create-deploy-python-django.html#python-django-configure-for-eb) article _(skip all the way to the Configure your Django application for Elastic Beanstalk section - step 3)_.

Once it is deployed, take the public URL for your deployed API and update the client side code to use that instead of `http://localhost:8000`.