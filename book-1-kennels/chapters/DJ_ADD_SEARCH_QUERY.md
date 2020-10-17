# Searching for Journal Entries

There needs to be a way to search journal entries that contain a word. The front end is trying to search for entries here:

```  
const searchEntries = (searchTerm) => {
    return fetch(`http://localhost:8088/entries?q=${searchTerm}`)
      .then(res => res.json())
      .then(setEntries);
  };
```
Instead of using `WHERE entry = <whatever word>` clause in the sql statement, research using `LIKE` or `CONTAINS` to find the entries

### To test:
Type a word in the entries search input. The displayed entries should all have that word in them.
