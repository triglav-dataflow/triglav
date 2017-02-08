## GET /api/v1/users
Returns user index<br/>Group is not included<br/>

### Example

#### Request
```
GET /api/v1/users HTTP/1.1
Accept: application/json
Authorization: 2a935f5950401e297f39726f430766aa
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 555
Content-Type: application/json; charset=utf-8
ETag: W/"093f734edd2d00acb8eea246f6ca68d0"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c4a25c4d-bb68-46f5-93ae-2f35cab74395
X-Runtime: 0.026282
X-XSS-Protection: 1; mode=block

[
  {
    "id": 84,
    "name": "project_admin",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 85,
    "name": "editable_user",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 86,
    "name": "read_only_user_1",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 87,
    "name": "read_only_user_2",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 88,
    "name": "read_only_user_3",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 89,
    "name": "user 1",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  }
]
```

## GET /api/v1/users/:user_id
Get a user

### Example

#### Request
```
GET /api/v1/users/90 HTTP/1.1
Accept: application/json
Authorization: 2e28d93c19cea76a372b00a0232ac205
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 240
Content-Type: application/json; charset=utf-8
ETag: W/"9f8c4285a416ea99ea34a54a63ffc94b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: de73e0b1-f9a7-4e6d-a3f5-4ef5f9c44516
X-Runtime: 0.008624
X-XSS-Protection: 1; mode=block

{
  "id": 90,
  "name": "user 2",
  "description": "description for user 2",
  "authenticator": "local",
  "groups": [
    "triglav_admin"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## POST /api/v1/users
Create a user<br/>`authenticator` parameter accepts only `local`<br/>`ldap` users are automatically created on authentication<br/>Specify an Array for `groups`

### Example

#### Request
```
POST /api/v1/users HTTP/1.1
Accept: application/json
Authorization: 6989edd0c9e8095dae4a78c10e6a8e10
Content-Length: 164
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "name": "new user",
  "description": "description for new user",
  "authenticator": "local",
  "email": "triglav-test@example.com",
  "groups": [
    "read_only"
  ],
  "password": "Passw0rd"
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 240
Content-Type: application/json; charset=utf-8
ETag: W/"167e9f3bba6aa3394da089b6a9ae61e5"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 1fc66629-9303-4534-a825-18d1e56bc204
X-Runtime: 0.111268
X-XSS-Protection: 1; mode=block

{
  "id": 92,
  "name": "new user",
  "description": "description for new user",
  "authenticator": "local",
  "groups": [
    "read_only"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## PUT /api/v1/users/:user_id
Update a user<br/>`authenticator` parameter accepts only `local`<br/>`name` cannot be changed (ignored even if specified)<br/>

### Example

#### Request
```
PUT /api/v1/users/94 HTTP/1.1
Accept: application/json
Authorization: 684cbfb0e6703444d561c7982c9bf3b9
Content-Length: 168
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "name": "try to update name",
  "description": "try to update description",
  "authenticator": "local",
  "email": "triglav-test@example.com",
  "groups": [
    "editor",
    "group1",
    "group2"
  ]
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 261
Content-Type: application/json; charset=utf-8
ETag: W/"b2877596d82b657d2a8663f157090905"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: bf49f630-0a07-4a1b-ac90-f7aee638385f
X-Runtime: 0.014409
X-XSS-Protection: 1; mode=block

{
  "id": 94,
  "name": "original name",
  "description": "try to update description",
  "authenticator": "local",
  "groups": [
    "editor",
    "group1",
    "group2"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## DELETE /api/v1/users/:user_id
Delete a user

### Example

#### Request
```
DELETE /api/v1/users/96 HTTP/1.1
Accept: application/json
Authorization: 0efc39af046b82950d5958f800756365
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 204
Cache-Control: no-cache
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d4c5b544-35c5-4632-8db0-c4d238a87a92
X-Runtime: 0.010318
X-XSS-Protection: 1; mode=block
```
