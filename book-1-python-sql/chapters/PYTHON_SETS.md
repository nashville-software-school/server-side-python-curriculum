# Sets

## Explanation
A set in Python is an unordered collection of unique items. Sets are mutable and do not allow duplicate elements. They are defined by enclosing elements in curly braces `{}` or by using the `set()` function.

## When to Use
Sets are used when you need to store unique items and perform operations like union, intersection, and difference efficiently. Common use cases include:
- Removing duplicates from a collection.
- Performing mathematical set operations.
- Maintaining collections of distinct items.

## Implementation Example
Let's create a simple word analysis application to demonstrate the power of sets. This application will:
1. Extract unique words from a paragraph.
2. Compare words from two paragraphs to find common and unique words.

### Step-by-Step Walkthrough

#### Step 1: Extract Unique Words
We will start by writing a function that takes a paragraph of text and returns a set of unique words.

```python
def extract_unique_words(paragraph):
    # Split the paragraph into words and convert them to lowercase
    words = paragraph.lower().split()

    # Create a set to store unique words
    unique_words = set(words)

    return unique_words

# Example paragraph
paragraph1 = "Python is a great programming language. Python is popular and powerful."

# Extracting unique words
unique_words1 = extract_unique_words(paragraph1)
print("Unique words in paragraph 1:", unique_words1)
```

#### Step 2: Compare Words from Two Paragraphs
Next, we'll write functions to compare words from two different paragraphs. We'll find the common words, words unique to the first paragraph, and words unique to the second paragraph.

```python
def find_common_words(set1, set2):
    return set1.intersection(set2)

def find_unique_words(set1, set2):
    return set1.difference(set2)

# Example paragraphs
paragraph2 = "Python is widely used in data science. Data science is an exciting field."

# Extracting unique words from the second paragraph
unique_words2 = extract_unique_words(paragraph2)
print("Unique words in paragraph 2:", unique_words2)

# Finding common words
common_words = find_common_words(unique_words1, unique_words2)
print("Common words:", common_words)

# Finding words unique to the first paragraph
unique_to_paragraph1 = find_unique_words(unique_words1, unique_words2)
print("Words unique to paragraph 1:", unique_to_paragraph1)

# Finding words unique to the second paragraph
unique_to_paragraph2 = find_unique_words(unique_words2, unique_words1)
print("Words unique to paragraph 2:", unique_to_paragraph2)
```

#### Step 3: Display Results
Finally, we'll write a function to display the results in a user-friendly format.

```python
def display_results(common, unique1, unique2):
    print("Comparison Results:")
    print("\nCommon Words:")
    for word in common:
        print(word)

    print("\nUnique Words in Paragraph 1:")
    for word in unique1:
        print(word)

    print("\nUnique Words in Paragraph 2:")
    for word in unique2:
        print(word)

# Displaying the comparison results
display_results(common_words, unique_to_paragraph1, unique_to_paragraph2)
```

### Full Example
Here's the complete code for our word analysis application:

```python
def extract_unique_words(paragraph):
    words = paragraph.lower().split()
    unique_words = set(words)
    return unique_words

def find_common_words(set1, set2):
    return set1.intersection(set2)

def find_unique_words(set1, set2):
    return set1.difference(set2)

def display_results(common, unique1, unique2):
    print("Comparison Results:")
    print("\nCommon Words:")
    for word in common:
        print(word)

    print("\nUnique Words in Paragraph 1:")
    for word in unique1:
        print(word)

    print("\nUnique Words in Paragraph 2:")
    for word in unique2:
        print(word)

# Example paragraphs
paragraph1 = "Python is a great programming language. Python is popular and powerful."
paragraph2 = "Python is widely used in data science. Data science is an exciting field."

# Extracting unique words from paragraphs
unique_words1 = extract_unique_words(paragraph1)
unique_words2 = extract_unique_words(paragraph2)

# Finding common and unique words
common_words = find_common_words(unique_words1, unique_words2)
unique_to_paragraph1 = find_unique_words(unique_words1, unique_words2)
unique_to_paragraph2 = find_unique_words(unique_words2, unique_words1)

# Displaying the comparison results
display_results(common_words, unique_to_paragraph1, unique_to_paragraph2)
```

## Beginner Task: Email List Management

Now that you've seen how sets can be used to compare text data, let's create an application to manage email lists. This task will help you practice adding, removing, displaying, and performing set operations on email addresses. Follow the instructions below:

### Instructions

1. **Initialize Empty Sets**
   - Create two empty sets named `subscribers` and `unsubscribers`.

2. **Add Emails to the Sets**
   - Write a function `add_email(email, set_name)` that adds an email to the specified set (`subscribers` or `unsubscribers`) and prints a message indicating the email was added.

3. **Remove Emails from the Sets**
   - Write a function `remove_email(email, set_name)` that removes an email from the specified set if it exists, and prints a message indicating the email was removed or a message if the email was not found.

4. **Display Emails in a Set**
   - Write a function `display_emails(set_name)` that prints all the emails in the specified set.

5. **Find Active Subscribers**
   - Write a function `find_active_subscribers()` that returns a set of emails that are in `subscribers` but not in `unsubscribers`.

### Starter Code

Create a Python module named `email_list.py` and start with the code below.

```python
# Initialize empty sets
subscribers = set()
unsubscribers = set()

# Function to add an email
def add_email(email, set_name):

    print(f"Email '{email}' added to {'subscribers' if set_name == subscribers else 'unsubscribers'}.")

# Function to remove an email
def remove_email(email, set_name):
    pass

# Function to display emails
def display_emails(set_name):
    pass

# Function to find active subscribers. Return the set.
def find_active_subscribers():
    pass

# Adding emails to subscribers (notice that some people subscribe more than once)
add_email("user1@example.com", subscribers)
add_email("user3@example.com", subscribers)
add_email("user4@example.com", subscribers)
add_email("user11@example.com", subscribers)
add_email("user5@example.com", subscribers)
add_email("user6@example.com", subscribers)
add_email("user2@example.com", subscribers)
add_email("user5@example.com", subscribers)
add_email("user2@example.com", subscribers)
add_email("user7@example.com", subscribers)
add_email("user8@example.com", subscribers)
add_email("user9@example.com", subscribers)
add_email("user2@example.com", subscribers)
add_email("user11@example.com", subscribers)
add_email("user7@example.com", subscribers)
add_email("user10@example.com", subscribers)
add_email("user12@example.com", subscribers)

# Adding emails to unsubscribers
add_email("user6@example.com", unsubscribers)
add_email("user8@example.com", unsubscribers)
add_email("user1@example.com", unsubscribers)
add_email("user10@example.com", unsubscribers)

# Displaying subscribers and unsubscribers
print("All Subscribers:")


print("All Unsubscribers:")


# Finding active subscribers
print("Active Subscribers:")
```

[Next chapter: Tuples >>](./TUPLES.md)