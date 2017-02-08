## POST /api/v1/auth/token
Returns access_token if authenticated.<br/>Authenticate with username, password registered via /api/v1/users<br/>If other APIs are requested with valid token, the expiration time of the token is extended<br/>

### Example

#### Request
```
POST /api/v1/auth/token HTTP/1.1
Accept: application/json
Content-Length: 51
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "username": "test_user",
  "password": "Test_passw0rd"
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 96
Content-Type: application/json; charset=utf-8
ETag: W/"e9838aeb030d20eb8c7f0c93328bc29e"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 801d5480-ae2b-4f8a-99ba-17533df4d412
X-Runtime: 0.184791
X-XSS-Protection: 1; mode=block

{
  "access_token": "f0f5ae58537642c7a2737519c42753e2",
  "expires_at": "2017-03-10T16:37:07.000+09:00"
}
```

## DELETE /api/v1/auth/token
Revoke access_token specified in Authorization header

### Example

#### Request
```
DELETE /api/v1/auth/token HTTP/1.1
Accept: application/json
Authorization: 6d60957c80ff746fb07ab734e8371718
Content-Length: 0
Content-Type: application/json
Host: medjed.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 204
Cache-Control: no-cache
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 814bdb2b-e358-4f4d-8c19-61a154467a47
X-Runtime: 0.009636
X-XSS-Protection: 1; mode=block
```

## GET /api/v1/auth/me
Returns user associted with the token specified in Authorization header<br/>The expiration time is extended if the token is valid<br/>

### Example

#### Request
```
GET /api/v1/auth/me HTTP/1.1
Accept: application/json
Authorization: d91984b7cbfebf97327e4ca45c2d8078
Content-Length: 0
Content-Type: application/json
Host: medjed.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 250
Content-Type: application/json; charset=utf-8
ETag: W/"937c172e519058e44c6d02606063f6d7"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: dd02cbb2-fbf9-43dc-af84-133d4f1e8471
X-Runtime: 0.007278
X-XSS-Protection: 1; mode=block

{
  "id": 100,
  "name": "editorial_user",
  "description": "description for editorial_user",
  "authenticator": "local",
  "groups": [
    "editor"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:37:07.000+09:00",
  "updated_at": "2017-02-08T16:37:07.000+09:00"
}
```
