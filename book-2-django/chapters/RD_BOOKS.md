# Managing Books

## Books ViewSet

1. Create a `views/books.py` module
2. Grab the code from below and paste it into the module.
3. Import the class into the views package init file.

<details>
    <summary>Book ViewSet Code</summary>

```py
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework import serializers
from digestapi.models import Book
from .categories import CategorySerializer


class BookSerializer(serializers.ModelSerializer):
    is_owner = serializers.SerializerMethodField()
    categories = CategorySerializer(many=True)

    def get_is_owner(self, obj):
        # Check if the authenticated user is the owner
        return self.context['request'].user == obj.user

    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'isbn_number', 'cover_image', 'is_owner', 'categories']


class BookViewSet(viewsets.ViewSet):

    def list(self, request):
        books = Book.objects.all()
        serializer = BookSerializer(books, many=True, context={'request': request})
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        try:
            book = Book.objects.get(pk=pk)
            serializer = BookSerializer(book, context={'request': request})
            return Response(serializer.data)

        except Book.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def create(self, request):
        # Get the data from the client's JSON payload
        title = request.data.get('title')
        author = request.data.get('author')
        isbn_number = request.data.get('isbn_number')
        cover_image = request.data.get('cover_image')

        # Create a book database row first, so you have a
        # primary key to work with
        book = Book.objects.create(
            user=request.user,
            title=title,
            author=author,
            cover_image=cover_image,
            isbn_number=isbn_number)

        # Establish the many-to-many relationships
        category_ids = request.data.get('categories', [])
        book.categories.set(category_ids)

        serializer = BookSerializer(book, context={'request': request})
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None):
        try:

            book = Book.objects.get(pk=pk)

            # Is the authenticated user allowed to edit this book?
            self.check_object_permissions(request, book)

            serializer = BookSerializer(data=request.data)
            if serializer.is_valid():
                book.title = serializer.validated_data['title']
                book.author = serializer.validated_data['author']
                book.isbn_number = serializer.validated_data['isbn_number']
                book.cover_image = serializer.validated_data['cover_image']
                book.save()

                category_ids = request.data.get('categories', [])
                book.categories.set(category_ids)

                serializer = BookSerializer(book, context={'request': request})
                return Response(None, status.HTTP_204_NO_CONTENT)

            return Response(serializer.errors, status.HTTP_400_BAD_REQUEST)

        except Book.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def destroy(self, request, pk=None):
        try:
            book = Book.objects.get(pk=pk)
            self.check_object_permissions(request, book)
            book.delete()

            return Response(status=status.HTTP_204_NO_CONTENT)

        except Book.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
```
</details>

## Create Books Route

Update your `urls.py` module to import the viewset.

```py
from digestapi.views import BookViewSet, UserViewSet, CategoryViewSet
```

Then add the route to the default router.

```py
router = DefaultRouter(trailing_slash=False)
router.register(r'books', BookViewSet, 'book')
```

## How It Works: Book Ownership

One of the cooler things about Django REST Framework serializers is that you can define properties to be in the JSON string that aren't defined on the model. Up until now, the `fields` list only contained field that you defined on the model class.

By using the `serializers.SerializerMethodField()` method, you can define ad-hoc properties to be injected into the response body. In the book serializer, the `get_is_owner()` method dynamically determines if the user that authenticated on the client is the same person who is the creator of the book.


```py
from .categories import CategorySerializer


class BookSerializer(serializers.ModelSerializer):
    # Override default serialization to replace foreign keys
    # with expanded related resource. By default, this would
    # be a list of integers (e.g. [2, 4, 9]).
    categories = CategorySerializer(many=True)

    # Declare that an ad-hoc property should be included in JSON
    is_owner = serializers.SerializerMethodField()

    # Function containing instructions for ad-hoc property
    def get_is_owner(self, obj):
        # Check if the authenticated user is the owner
        return self.context['request'].user == obj.user

    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'isbn_number', 'cover_image', 'is_owner', 'categories']
```

In order for that to work, the `request` object needs to be provided as a bit of context for the serializer. Note the new `context` argument provided in the list method.

```py
class BookViewSet(viewsets.ViewSet):

    def list(self, request):
        books = Book.objects.all()
        serializer = BookSerializer(
            books,
            many=True,
            context={'request': request} # Allow serializer to access request
        )
        return Response(serializer.data)

```

## How It Works: Creating Many-To-Many Entries

Many to many relationships are a difficult mechanism to work with for beginners, so Django REST Framework (DRF) tries to make it as simple as possible. Reflect on the following scenario.

In the client, when a user creates a book entry, there will be a checkbox for every category. The user can choose as many categories as are needed. Assume that the user picks 2 categories. The primary key for the ones chosen are 3 and 5.

When the client sends a POST request to save the book details into the database, the request JSON payload would look like this.

```json
{
    "title": "The Neverending Story",
    "author": "Edwin R. Billows",
    "isbn_number": "8573282904",
    "cover_image": "http://www.allbooks.com/neverendingstory/images/cover.png",
    "categories": [3, 5]
}
```

As you can see, the categories are sent as a nested array in the JSON.

How is this handled by the view set during creation?

First, you get the list of integers from the request payload with `request.data.get()`.

Secondly, you establish the new relationships between the book that was just created _(assume it's new primary key is 12)_ and categories 3 and 5 by using the `.set()` method on the model property of `categories`.

```py
# Get the list of [3, 5] from the request payload
category_ids = request.data.get('categories', [])

# Assign categories 3 and 5 to the new book 12 with one line of code
book.categories.set(category_ids)
```

Now in the `digestapi_book_category` table in the database, there will be 2 new rows.

| id | book_id | category_id |
|--|--|--|
| 56 | 12 | 3 |
| 57 | 12 | 5 |
