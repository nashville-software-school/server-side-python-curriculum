# Declarative Implementation Intro

## Initial Project Goals

You have several goals during this project, and most of them require thought, discussion, and documentation. It is time to start preparing you for being a professional junior developer who will need to learn an existing codebase.

1. Produce a sequence diagram for this project.
2. Discuss and document why this code is written in declarative style.
3. Discuss and document the pros and cons of declarative code.
4. Implement the ability to allow clients to POST data to the API.
5. Discuss and document how either composition or inheritance is used in this project.


## Running the API

1. Start the API in debug mode with **Shift+Alt+D**. The process will start and will be listening for HTTP requests on port 8000.
2. Open Postman and make a GET request to `http://localhost:8000/ships`.
3. Verify that you receive the JSON representation of 12 ships in the response body and that the status code on the response is 200.
4. Explore the code for the API, determine which types of requests that it appears to support and test each one to verify that they work.

## Next Step

After you team has some baseline familiarity with the operations currently supported by the project, the first goal is to produce the sequence diagram.

[Go to sequence diagram chapter >](./SS_API_DECLARATIVE_SEQUENCE.md)