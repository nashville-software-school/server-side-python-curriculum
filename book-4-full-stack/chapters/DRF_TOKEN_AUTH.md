# Authentication in Django REST Framework

## Registering a New User

```js
fetch("http://localhost:8000/register", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify({
        "username": document.querySelector("#username").value,
        "password": document.querySelector("#password").value,
        "email": document.querySelector("#email").value,
        "first_name": document.querySelector("#firstName").value,
        "last_name": document.querySelector("#lastName").value
    })
})
.then(authResponse => {
    if (authResponse.data.token !== "") {
        sessionStorage.setItem("kennywood_token", authResponse.data.token)

        this.props.history.push("/")
    }
})
```

## Getting a New Token

```js
fetch("http://localhost:8000/api-token-auth/", {
    method: "POST",
    body: JSON.stringify({
        "username": $scope.user.username,
        "password": $scope.user.password
    })
})
.then(loginResponse => {
    if (loginResponse.data.token !== "") {
        sessionStorage.setItem("kennywood_token", loginResponse.data.token)

        this.props.history.push("/")
    }
})
```