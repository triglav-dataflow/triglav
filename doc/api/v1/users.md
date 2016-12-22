## GET /api/v1/users
Returns user index<br/>Group is not included<br/>

### Example

#### Request
```
GET /api/v1/users HTTP/1.1
Accept: application/json
Authorization: ab1f93ed2c19cc1fa9b744b0492ee521
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
ETag: W/"5909c79aee88e0b3ce69e9c70140ce56"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a3fdb4b0-5f30-406b-8aa4-0f684781dcd0
X-Runtime: 0.019629
X-XSS-Protection: 1; mode=block

[
  {
    "id": 110,
    "name": "project_admin",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 111,
    "name": "editable_user",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 112,
    "name": "read_only_user_1",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 113,
    "name": "read_only_user_2",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 114,
    "name": "read_only_user_3",
    "authenticator": "local",
    "email": "triglav-test@example.com"
  },
  {
    "id": 115,
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
GET /api/v1/users/116 HTTP/1.1
Accept: application/json
Authorization: eb61807986deb53a9aefd4e1a0b68182
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
ETag: W/"6dd1f152a102e98b3b6b8091a4ca17d9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a0c9a87c-2013-4c20-8132-a7a190649e64
X-Runtime: 0.008616
X-XSS-Protection: 1; mode=block

{
  "id": 116,
  "name": "user 2",
  "description": "description for user 2",
  "authenticator": "local",
  "groups": [
    "triglav_admin"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2016-12-16T20:20:47.000+09:00",
  "updated_at": "2016-12-16T20:20:47.000+09:00"
}
```

## POST /api/v1/users
Create a user<br/>`authenticator` parameter accepts only `local`<br/>`ldap` users are automatically created on authentication<br/>Specify an Array for `groups`

### Example

#### Request
```
POST /api/v1/users HTTP/1.1
Accept: application/json
Authorization: 5d6788cf39fe0223bb86089a57e6f281
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
ETag: W/"74ce7f75d3b4ae173eba3b7d4764bb20"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d95ac468-61bb-4c38-8445-f588e700b704
X-Runtime: 0.103923
X-XSS-Protection: 1; mode=block

{
  "id": 118,
  "name": "new user",
  "description": "description for new user",
  "authenticator": "local",
  "groups": [
    "read_only"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2016-12-16T20:20:47.000+09:00",
  "updated_at": "2016-12-16T20:20:47.000+09:00"
}
```

## PUT /api/v1/users/:user_id
Update a user<br/>`authenticator` parameter accepts only `local`<br/>`name` cannot be changed (ignored even if specified)<br/>

### Example

#### Request
```
PUT /api/v1/users/120 HTTP/1.1
Accept: application/json
Authorization: b4f9298c7ee2c00d1159ff8b4bc8d0c9
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
ETag: W/"96b505ff75570d17b38f392886de4f45"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 57fe3c86-618a-485d-a19f-95288f2bfb4f
X-Runtime: 0.014072
X-XSS-Protection: 1; mode=block

{
  "id": 120,
  "name": "original name",
  "description": "try to update description",
  "authenticator": "local",
  "groups": [
    "editor",
    "group1",
    "group2"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2016-12-16T20:20:47.000+09:00",
  "updated_at": "2016-12-16T20:20:47.000+09:00"
}
```

## DELETE /api/v1/users/:user_id
Delete a user

### Example

#### Request
```
DELETE /api/v1/users/122 HTTP/1.1
Accept: application/json
Authorization: 8580fe9246757aa32a46f31218e60466
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
X-Request-Id: 5b83c6ee-5571-44a7-a840-11631456b79e
X-Runtime: 0.008122
X-XSS-Protection: 1; mode=block
```
