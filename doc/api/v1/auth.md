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
ETag: W/"e86c7a95ccd4101ea6840ac45f22dc9d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c7d0f061-44ff-4dff-9ca6-400de1daccfb
X-Runtime: 0.109011
X-XSS-Protection: 1; mode=block

{
  "access_token": "4205465110a3ba69bc9c99e299b0d773",
  "expires_at": "2016-12-05T04:59:21.000+09:00"
}
```

## DELETE /api/v1/auth/token
Revoke access_token specified in Authorization header

### Example

#### Request
```
DELETE /api/v1/auth/token HTTP/1.1
Accept: application/json
Authorization: a1dae808c266f83d307bceb5c78e8dd0
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
X-Request-Id: 75bc65ca-3418-41fb-b7c5-cb1a8992dd7f
X-Runtime: 0.010984
X-XSS-Protection: 1; mode=block
```

## GET /api/v1/auth/me
Returns user associted with the token specified in Authorization header<br/>The expiration time is extended if the token is valid<br/>

### Example

#### Request
```
GET /api/v1/auth/me HTTP/1.1
Accept: application/json
Authorization: 7d2837c0a70d24e1f5ff79670d5a2fa6
Content-Length: 0
Content-Type: application/json
Host: medjed.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 248
Content-Type: application/json; charset=utf-8
ETag: W/"0c5d767eccb1882f8ff05522eaf6d9a1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f56e5d3c-a8a6-426d-8203-27b2b5b53199
X-Runtime: 0.004525
X-XSS-Protection: 1; mode=block

{
  "id": 9,
  "name": "editorial_user",
  "description": "description for editorial_user",
  "authenticator": "local",
  "groups": [
    "editor"
  ],
  "email": "triglav-test@example.com",
  "created_at": "2016-11-05T04:59:21.000+09:00",
  "updated_at": "2016-11-05T04:59:21.000+09:00"
}
```
