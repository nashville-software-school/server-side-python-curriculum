# Book Reviews

For Reader's Digest, any user can leave a review for any book in the system. A user can delete a previously created review, but it cannot be edited. A user cannot delete another user's review.

Just as you did in the book serializer, you will have a custom property added during the serialization process named `is_owner` that will return `true` or `false` if the review was created by the currently authenticated user.

## Review ViewSet

1. Create a `views/reviews.py` module
2. Grab the code from below and paste it into the module.
3. Fill in the required code where needed.
4. Import the class into the views package init file.

<details>
    <summary>Review ViewSet Code</summary>

```py
from rest_framework import viewsets, status, serializers, permissions
from rest_framework.response import Response
from digestapi.models import Review

class ReviewSerializer(serializers.ModelSerializer):
    is_owner = serializers.SerializerMethodField()

    class Meta:
        model = Review
        fields = ['id', 'book', 'user', 'rating', 'comment', 'date_posted', 'is_owner']
        read_only_fields = ['user']

    def get_is_owner(self, obj):
        # Check if the user is the owner of the review
        return self.context['request'].user == obj.user


class ReviewViewSet(viewsets.ViewSet):
    permission_classes = [permissions.AllowAny]

    def list(self, request):
        # Get all reviews

        # Serialize the objects, and pass request to determine owner
        serializer = ReviewSerializer(reviews, many=True, context={'request': request})

        # Return the serialized data with 200 status code


    def create(self, request):
        # Create a new instance of a review and assign property
        # values from the request payload using `request.data`


        # Save the review

        try:
            # Serialize the objects, and pass request as context

            # Return the serialized data with 201 status code

        except Exception as ex:
            return Response(None, status=status.HTTP_400_BAD_REQUEST)

    def retrieve(self, request, pk=None):
        try:
            # Get the requested review

            # Serialize the object (make sure to pass the request as context)

            # Return the review with 200 status code

        except Review.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def destroy(self, request, pk=None):
        try:
            # Get the requested review
            review = Review.objects.get(pk=pk)

            # Check if the user has permission to delete
            # Will return 403 if authenticated user is not author
            if review.user.id != request.user.id:
                return Response(status=status.HTTP_403_FORBIDDEN)

            # Delete the review
            review.delete()

            # Return success but no body
            return Response(status=status.HTTP_204_NO_CONTENT)

        except Review.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
```
</details>

## Create Reviews Route

1. Import the viewset into `urls.py`
2. Register a new route `reviews` with the default router.

## Testing

Using Postman, validate all supported actions for this view.

| Method | Route | Validation |
|--|--|--|
| GET | /reviews | All reviews returned with correct **owner** value |
| GET | /reviews/n | Single review returned with correct **owner** value and 200 status code |
| DELETE | /reviews/n | Delete a review not owned by you and verify 403 status code |
| DELETE | /reviews/n | Delete a review owned by you and verify 204 status code |
| POST | /reviews | JSON representation returned with 201 status code |
