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
ETag: W/"5e85b6025665532b5583d2253f111e91"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 09804d3f-468b-4a17-94d2-f7621fb29143
X-Runtime: 0.200990
X-XSS-Protection: 1; mode=block

{
  "access_token": "3530e2d7616044b58c381284bdb3a7c5",
  "expires_at": "2017-03-10T16:24:24.000+09:00"
}
```

## DELETE /api/v1/auth/token
Revoke access_token specified in Authorization header

### Example

#### Request
```
DELETE /api/v1/auth/token HTTP/1.1
Accept: application/json
Authorization: e47fdee905e994c60db7f2c76abd33f3
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
X-Request-Id: 5a59e0f3-a164-46b4-bc69-f1402502fbd7
X-Runtime: 0.008624
X-XSS-Protection: 1; mode=block
```

## GET /api/v1/auth/me
Returns user associted with the token specified in Authorization header<br/>The expiration time is extended if the token is valid<br/>

### Example

#### Request
```
GET /api/v1/auth/me HTTP/1.1
Accept: application/json
Authorization: deded3fcef7fab4e9fefcb714be68775
Content-Length: 0
Content-Type: application/json
Host: medjed.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 249
Content-Type: application/json; charset=utf-8
ETag: W/"880f135feba2d331214654b3cf5290a4"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 76352c3d-9399-4c4e-8396-8cdaddf60edb
X-Runtime: 0.010133
X-XSS-Protection: 1; mode=block

{
  "id": 64,
  "name": "editorial_user",
  "description": "description for editorial_user",
  "authenticator": "local",
  "groups": [
    "editor"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:24:24.000+09:00",
  "updated_at": "2017-02-08T16:24:24.000+09:00"
}
```
