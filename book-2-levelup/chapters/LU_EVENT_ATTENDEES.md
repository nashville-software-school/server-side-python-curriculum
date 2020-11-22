# Event Attendee Count

Your task is to use the instructions from the previous chapter, and use...

1. The `annotate()` method
1. The `Count()` method
1. The `related_name` attribute
1. Custom model properties
1. Model serializer field

...to add a `attendees` property to the JSON that gets returned for a list of events.

In the `list()` method of event viewset, change the `events = Event.objects.all()` statement to use `annotate()` to ensure that `attendees` property is added.

## Bonus

Use the `annotate()` method before the `get()` method in the `retrieve()` method of your event viewset to include attendees on a request for a single resource.
