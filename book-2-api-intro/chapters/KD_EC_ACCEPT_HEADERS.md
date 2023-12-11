# Accept Headers for 405 Responses

According to Web standards, when a server responds with a 405 status code...

> The server must generate an Allow header field in a 405 status code response. The field must contain a list of methods that the target resource currently supports.
> https://developer.mozilla.org/en-US/docs/web/http/status/405

Your API returns a 405 status in many situations. Find the `set_response_code()` function and the `response()` function in your project and see if you can modify them to allow you to specify which methods are allowed.

| Resource | Unsupported Method(s) | Allowed Methods |
|--|--|--|
| /orders/_n_ | PUT | GET, POST, DELETE |
| /styles | POST, PUT, DELETE | GET |
| /styles/_n_ | POST, PUT, DELETE | GET |
| /sizes | POST, PUT, DELETE | GET |
| /sizes/_n_ | POST, PUT, DELETE | GET |
| /metals | POST, PUT, DELETE | GET |
| /metals/_n_ | POST, PUT, DELETE | GET |