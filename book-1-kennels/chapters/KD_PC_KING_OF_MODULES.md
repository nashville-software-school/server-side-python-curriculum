# Sovereign of Modules and Logic

If you happen to be one of the few, special, chosen ones who was able to successfully refactor the Python Kennels code to have the data and all of the data access functions in a single module, then do we have a challenge for you.

Given the following business requirements, what is the most DRY code that you can write, without sacrificing readability, and using appropriate abstractions?

1. Styles cannot be deleted, updated, or created by the client.
1. Sizes cannot be deleted, updated, or created by the client.
1. Metals cannot be deleted or created by the client. Updates are allowed to accomodate changes in metal prices on the market.
1. Orders cannot be deleted or updated by the client.
1. Orders should have the calculated total price added to the response JSON
    ```json
    // GET http://localhost:8088/orders/3
    {
        "timestamp": 1616334884289,
        "id": 3,
        "style": { "id": 1, "style": "Classic", "price": 500 },
        "metal": { "id": 1, "metal": "Sterling Silver", "price": 12.42 },
        "size": { "id": 1, "carets": 0.5, "price": 405 },
        "price": 917.42
    }
    ```
1. When requesting a single order, the client can use query string parameters to optionally expand any of the three foreign keys. Right now, they are automatically expanded. To tackle this one, you will need some starter code.
    <details>
        <summary>Expand to get your starter code</summary>

    ```py
    # Import this stdlib package first
    from urllib.parse import urlparse
    ```

    ```py
    # Replace existing function with this
    def parse_url(self, path):
        url_components = urlparse(path)
        path_params = url_components.path.strip("/").split("/")
        query_params = url_components.query.split("&")
        resource = path_params[0]
        id = None

        try:
            id = int(path_params[1])
        except IndexError:
            pass
        except ValueError:
            pass

        return (resource, id, query_params)
    ```
    </details>
