# Resources and Verbs

Before you jump into building web applications with Python, Django, and SQL, you need to have some understanding about how to access resources on the World Wide Web _(URIs or Uniform Resource Identifiers)_ and how you should manipulate those resources _(with HTTP verbs)_.

## Resources

In the application you are going to build, there are three resources.

1. Libraries
1. Librarians
1. Books

Each individual library, librarian, and book will have a specific URI - specifically, one that specifies how to identify it on a network. That network happens to be the World Wide Web. These types of URI are more commonly referred to as URLs, or Uniform Resource Locators.

Not only do the individual resources have a URI, but the collections themselves have a URI.

* URI of the book collection: http://localhost:8000/books
* URI of the twelfth book in the collection: http://localhost:8000/books/12

Other things needed to support the management of the main resources will also get their own URI. For example, to let a user create a new book, you need to present them with an HTML document with a form in it. That form will also have a unique URI.

http://localhost:8000/book/form

## Verbs

A brief description of the verb involves relating the four most used verbs to the four most common operations that happen in web applications.

| **Action**  | **Verb**  |
|---|---|
| Create resource  | POST _(almost always)_ or PUT  |
| Modify resource  | PUT  |
| Delete resource  | DELETE  |
| Transfer resource state from server -> client  | GET  |

---

#### Specification Exerpt

The following exerpt is from the HTTP/1.1 specification written by [Roy Fielding](https://en.wikipedia.org/wiki/Roy_Fielding) and others.

https://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-16#section-7.5

> Proper interpretation of a PUT request presumes that the client knows what target resource is desired. A service that is intended to select a proper URI on behalf of the client, after receiving a state changing request, SHOULD be implemented using the POST method rather than PUT.

---

This is why the POST verb is _almost always_ used to create things in web applications because ownership and control of the database falls to the server. Therefore, a client cannot know which `id` value is next in the database, so it allows the server to specify the URI upon creation.

## Guidance

Because of how resources should be defined, and how verbs drive their change in state, be cognizant of how you define your URIs in your Django applications.

* Requests that change to the state of the book collection resource should be sent to `/books`
* Requests that change the state of a single book should be sent to `/books/{id}`.

For more guidance, please read the [REST Resource Naming Guide](https://restfulapi.net/resource-naming/).