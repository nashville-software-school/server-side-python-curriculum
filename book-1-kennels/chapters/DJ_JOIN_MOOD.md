# Including Mood on Entry

In the Daily Journal application, the possible moods are stored in a separate table, and a journal entry stores a foreign key reference to it.

#### Data as JSON

```json
{
    "moods": [
        { "id": 1, "mood": "Sad" },
        { "id": 2, "mood": "Ok" },
        { "id": 3, "mood": "Happy" }
    ],
    "entries": [
        {
            "id": 1,
            "entry": "Python basics today",
            "concept": "Variables",
            "date": 1598309852296,
            "moodId": 2
        }
    ]
}
```

If the client requests a single entry, the actual mood would not be in the response. It would be a meaningless `2`, which is not what you want to display to the user in the browser.

## Nested Data Response

Then the client requests http://localhost:8088/entries to get all entries, or http://localhost:8088/entries/1 to get a single entry, the related mood object should be nested in the response.

```json
{
    "id": 1,
    "entry": "Python basics today",
    "concept": "Variables",
    "date": 1598309852296,
    "moodId": 2,
    "mood": {
        "id": 2,
        "mood": "Ok"
    }
}
```

Then the client can simply access the `mood` property in JavaScript to display it.

#### Example

```js
export const Entry = (entryObject) => {
    return `
        <section id="mood--${entryObject.id}">
            <div>My mood was ${entryObject.mood} when I learned this</div>
        </section>
    `
}
```