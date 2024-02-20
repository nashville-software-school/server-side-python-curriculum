# Installing and Configuring Swagger

## Installation

Install the package.

```sh
pipenv install drf-yasg
```

Add the following configuration block to `settings.py`

```py
SWAGGER_SETTINGS = {
    'SECURITY_DEFINITIONS': {
        'Bearer': {
            'type': 'apiKey',
            'name': 'Authorization',
            'in': 'header'
        }
    },
    "exclude_namespaces": [],  # List URL namespaces to ignore
    "api_version": '0.1',  # Specify your API's version
    "api_path": "/",  # Specify the path to your API not a root level
    "enabled_methods": [  # Specify which methods to enable in Swagger UI
        'get',
        'post',
        'put',
        'patch',
        'delete'
    ],
    "is_authenticated": False,  # Set to True to enforce user authentication,
    "is_superuser": False,  # Set to True to enforce admin only access
}
```

Add `drf_yasg` to the INSTALLED_APPS section.

```py
INSTALLED_APPS = [
    ...
    'drf_yasg',
    ...
]
```

## Application Configuration

Add the following imports to `urls.py`


```py
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions
```

Right below all of your imports in `urls.py` add the following configuration.

```py
schema_view = get_schema_view(
    openapi.Info(
        title="LevelUp API",
        default_version='v1',
        description="API for creating games and events",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="contact@levelup.local"),
        license=openapi.License(name="BSD License"),
    ),

    public=True,
    permission_classes=[permissions.AllowAny],
)
```

Add the following route definition in `urls.py`.


```py
urlpatterns = [
    ...
    re_path(r'^swagger/$', schema_view.with_ui('swagger',
            cache_timeout=0), name='schema-swagger-ui'),
    ...
]
```