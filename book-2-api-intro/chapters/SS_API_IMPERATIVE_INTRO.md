# Imperative Implementation Intro

## Imperative and Declarative Code

It's time to learn about an important concept in software development. It is crucial that you learn about this now because you will be writing **much more** declarative code, whereas in the client side course, you wrote much more imperative code until you hit React.

When you learned React, you had your first introduction to more declarative code.

Take a few minutes to read the [Imperative vs Declarative Programming – the Difference Explained in Plain English](https://www.freecodecamp.org/news/imperative-vs-declarative-programming-difference/) article to learn the basics of the different between the two types of coding.

## Initial Project Goals

You have several goals during this project, and most of them require thought, discussion, and documentation. It is time to start preparing you for being a professional junior developer who will need to learn an existing codebase.

1. Produce a sequence diagram for this project.
2. Discuss and document why this code is written in imperative style.
3. Discuss and document the pros and cons of imperative code.
4. Implement the ability to allow clients to POST data to the API.
5. Discuss and document how either composition or inheritance is used in this project.


## Running the API

1. Start the API in debug mode with **Shift+Alt+D**. The process will start and will be listening for HTTP requests on port 8000.
2. Open Postman and make a GET request to `http://localhost:8000/ships`.
3. Verify that you receive the JSON representation of 12 ships in the response body and that the status code on the response is 200.
4. Open up the `json-server.py` module and explore the code for the API, determine which types of requests that it appears to support and test each one to verify that they work.

## Next Step

After you team has some baseline familiarity with the operations currently supported by the project, the first goal is to produce the sequence diagram.

[Go to sequence diagram chapter >](./SS_API_IMPERATIVE_SEQUENCE.md)