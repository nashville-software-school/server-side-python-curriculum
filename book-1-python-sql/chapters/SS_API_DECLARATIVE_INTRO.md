## Traits of Declarative Coding

Declarative coding style is a programming paradigm that emphasizes expressing the logic of a computation without describing its control flow. In other words, it focuses on the "what" rather than the "how". Here are some of the key traits of declarative coding style:

1. **High-Level Abstraction**: Declarative code often abstracts away the underlying implementation details, allowing developers to express logic at a higher level.

2. **Expressiveness**: The code is often more concise because it doesn't need to spell out every step of the process.

3. **No Side Effects**: In purely declarative languages or styles, functions or expressions don't have side effects. They produce the same output for the same input without altering any state.

4. **Immutability**: Data is often immutable, meaning once it's created, it can't be changed. Instead of modifying data, new data is derived from the old.

5. **Descriptive**: The code describes the desired outcome rather than the steps to achieve it. For example, SQL is a declarative language where you describe the data you want, not how to retrieve it.

6. **Easier Parallel Processing**: Due to the lack of side effects and the focus on data transformation, declarative code can be more easily parallelized.

7. **Functional**: While not all declarative code is functional, functional programming is a subset of declarative programming. Functional languages like Haskell or Elm emphasize pure functions and avoid mutable state.

8. **Specification Over Implementation**: The developer specifies what needs to be done, and the underlying system or language runtime determines how best to do it.

9. **Idempotency**: In some declarative contexts, especially in infrastructure as code (like Terraform), operations are idempotent. This means performing the operation once has the same effect as performing it multiple times.

10. **Clear Separation**: There's often a clear separation between data and logic. This can make the code more readable and maintainable.

Examples of declarative paradigms or tools include:

- SQL for database queries.
- HTML for web page structure.
- CSS for styling web content.
- Functional programming languages like Haskell.
- Infrastructure as code tools like Terraform or CloudFormation.

Contrast this with imperative programming, where developers explicitly detail the steps the computer must take to achieve a desired state. While declarative code can be more concise and expressive, it might sometimes be less performant or harder to debug than imperative code, depending on the context and tools used.

## Next Step

Time to get started on the project.

[Cloning the project >](./SS_API_DECLARATIVE_CLONE.md)