# Event Attendee Count

Your task is to use the `annotate` property, the `Count()` method, the `related_name` attribute, and custom properties to add a `attendees` property to the JSON that gets returned for a list of events.

In the `list()` method of event viewset, change the `events = Event.objects.all()` statement to use `annotate()` to ensure that `attendees` property is added.

1. Make sure there is a `related_name` attribute being used in the event model.
1. You will need a custom property on the event model.
1. You will need to serialize that custom property.