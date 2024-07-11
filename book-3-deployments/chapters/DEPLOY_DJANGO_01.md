# Step 1: Preparing Your Project

First, if you haven't used Digital Ocean yet, [sign up for 60-day, $200 credit](https://m.do.co/c/47e5e578d1cd).

## Overview

To deploy your Django REST API to the cloud, you are going use the Digital Ocean platform. Be aware that deploying any non-static application will incur some costs - on any platform. For Digital Ocean, the cost is $5.00/month 💰 💰, so if you are unwilling or unable to take on that cost, do not follow these steps.

## Settings

Open the `settings.py` file for your project

Add the following imports to the module.

```py
import os
from django.core.management.utils import get_random_secret_key
```

Update each of the settings displayed below to the values provided. If you copy pasta this code block, make sure you remove any duplicate settings already established in the module.

```py
SECRET_KEY = os.getenv("DJANGO_SECRET_KEY", get_random_secret_key())
DEBUG = os.getenv("DEBUG", "False")
ALLOWED_HOSTS = os.getenv("DJANGO_ALLOWED_HOSTS", '').split(",")
DEVELOPMENT_MODE = os.getenv("DEVELOPMENT_MODE", "False")
```

[Go to Step 2 >](./DEPLOY_DJANGO_02.md)