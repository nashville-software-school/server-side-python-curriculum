# Implementing POST Capabilities

The initial state of the project supports GET, PUT, and DELETE requests from a client for all three resources.

1. Ships
2. Haulers
3. Docks

It does not support POST to create new rows in any of those database tables. Your team's job is to follow the current patterns of the project's code to implement this feature for all three resources.

There is a `do_POST()` method in the **JSONServer** class for you to work with. Utilize what you've learned about the highly functional. declarative style of the current code to implement this feature.

## Team Reflection Time

Once you have implemented support for POST operations, your team is encouraged to review the code base thoroughly, and then discuss if there are additional opportunities to make the code more functional.

- Are there any blocks of code that are repeated in the project that can be made into a function?
- Is there any **overly** declarative code that should be refactored to an imperative style to increase readability?

## Next Steps

Once your team has achieved all goals for this project and documented your observations and conclusions, reach out to an instructor for a comprehensive retrospective and code review. In this retrospective, you will not be focusing specifically on code, but more on higher-order concepts and how you arrived at your decisions.

Once that retrospective is done, each teammate will be building their own React client for this API.

[Build your Shipping Ships Client >](./SS_API_CLIENT.md)