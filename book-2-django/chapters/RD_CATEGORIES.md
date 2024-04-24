# Getting Categories

For this application, users can't make new categories, edit them, or delete them. That means you only have to implement `list` and `retrieve` so that a client can GET categories in JSON format.


## Category ViewSet

1. Create a `views/categories.py` module
2. Grab the code from below and paste it into the module.
3. Import the class into the views package init file.

<details>
    <summary>Category ViewSet Code</summary>

```py
from rest_framework import viewsets, status
from rest_framework import serializers
from rest_framework.response import Response
from digestapi.models import Category

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id', 'name']


class CategoryViewSet(viewsets.ViewSet):

    def list(self, request):
        categories = Category.objects.all()
        serializer = CategorySerializer(categories, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        try:
            category = Category.objects.get(pk=pk)
            serializer = CategorySerializer(category)
            return Response(serializer.data)
        except Category.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
```
</details>

## Create Categories Route

Update your `urls.py` module to import the viewset.

```py
from digestapi.views import UserViewSet, CategoryViewSet
```

Then add the route to the default router.

```py
router.register(r'categories', CategoryViewSet, 'category')
```

## Create Fixtures

Now create a `digestapi/fixtures/categories.json` file, add some fixtures and load them into the database.

Create about 5.

Once you have fixtures, update the `seed_database.sh` script to load them. Then run the seed script to start from scratch.


## Reference

[Rock of Ages fixtures](./ROA_FIXTURES.md)