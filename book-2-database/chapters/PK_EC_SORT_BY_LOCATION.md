# Sorting Query by Location

## Setup

Open your `request_handler` module and replace the `parse_url` method with the following code. Do not look directly at it. Just copy pasta. Don't ask questions about it. Just USE IT.

```py
    def parse_url(self, path):
        url_components = urlparse(path)
        path_params = url_components.path.strip("/").split("/")
        query_params = []

        if url_components.query != '':
            query_params = url_components.query.split("&")

        resource = path_params[0]
        id = None

        try:
            id = int(path_params[1])
        except IndexError:
            pass  # No route parameter exists: /animals
        except ValueError:
            pass  # Request had trailing slash: /animals/

        return (resource, id, query_params)
```

Then add the following import at the top of the file.

```py
from urllib.parse import urlparse
```

## Guidance

* Guidance on researching splitting a string that they get from `query_params`
* Explain that an f-string is needed and provide example
* Explain that the `location` passed by the client has to be used as `location_id` in the SQL string