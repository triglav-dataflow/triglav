## GET /api/v1/users
Returns user index<br/>Group is not included<br/>

### Example

#### Request
```
GET /api/v1/users HTTP/1.1
Accept: application/json
Authorization: 3dedf50aecb1b29e8ef63871ee5c5275
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 561
Content-Type: application/json; charset=utf-8
ETag: W/"465e3792ac7870b657e2cbedd27505f9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 38daed6e-db0e-4fcc-ad8a-e895221da704
X-Runtime: 0.018265
X-XSS-Protection: 1; mode=block

[
  {
    "id": 120,
    "name": "project_admin",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 121,
    "name": "editable_user",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 122,
    "name": "read_only_user_1",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 123,
    "name": "read_only_user_2",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 124,
    "name": "read_only_user_3",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 125,
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
GET /api/v1/users/126 HTTP/1.1
Accept: application/json
Authorization: 1239b64ee7ff62cdd1cab72d247c4847
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 241
Content-Type: application/json; charset=utf-8
ETag: W/"944f1cdaa23aad16fd407287c0098f28"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0f7fb897-ff99-4af5-b9a3-1b1f9da10d68
X-Runtime: 0.006447
X-XSS-Protection: 1; mode=block

{
  "id": 126,
  "name": "user 2",
  "description": "description for user 2",
  "authenticator": "local",
  "groups": [
    "triglav_admin"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00"
}
```

## POST /api/v1/users
Create a user<br/>`authenticator` parameter accepts only `local`<br/>`ldap` users are automatically created on authentication<br/>Specify an Array for `groups`

### Example

#### Request
```
POST /api/v1/users HTTP/1.1
Accept: application/json
Authorization: bda3f208ac32031562935a99fc25b9d6
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
Content-Length: 241
Content-Type: application/json; charset=utf-8
ETag: W/"a345d8990f2a13b5a18adf79f0269afd"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e5bf5227-79ff-4971-9747-4556a1f65811
X-Runtime: 0.102518
X-XSS-Protection: 1; mode=block

{
  "id": 128,
  "name": "new user",
  "description": "description for new user",
  "authenticator": "local",
  "groups": [
    "read_only"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00"
}
```

## PUT /api/v1/users/:user_id
Update a user<br/>`authenticator` parameter accepts only `local`<br/>`name` cannot be changed (ignored even if specified)<br/>

### Example

#### Request
```
PUT /api/v1/users/130 HTTP/1.1
Accept: application/json
Authorization: c48cbcbd17df1c16fcda3b8bd5c8e1a3
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
Content-Length: 262
Content-Type: application/json; charset=utf-8
ETag: W/"53cbd90168319d9c73433bad2141b363"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d96aa3f3-997f-4a0f-b8ec-a87971c34dfa
X-Runtime: 0.012336
X-XSS-Protection: 1; mode=block

{
  "id": 130,
  "name": "original name",
  "description": "try to update description",
  "authenticator": "local",
  "groups": [
    "editor",
    "group1",
    "group2"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:09.000+09:00"
}
```

## DELETE /api/v1/users/:user_id
Delete a user

### Example

#### Request
```
DELETE /api/v1/users/132 HTTP/1.1
Accept: application/json
Authorization: 56045a056eb9fe19c1f2d68b5e16a2e8
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
X-Request-Id: 5104445f-3ad2-4394-a971-0571e87b3822
X-Runtime: 0.008852
X-XSS-Protection: 1; mode=block
```
