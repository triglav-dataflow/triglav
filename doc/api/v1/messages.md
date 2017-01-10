## GET /api/v1/messages
List messages whose message id is greater than or equal to offset with HTTP GET method<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100.<br/>Returned `resource_time` is in unix timestamp<br/><br/>You can use either of GET /messages or POST /fetch_messages, but note that GET has limitation for query parameters length<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=29&limit=100 HTTP/1.1
Accept: application/json
Authorization: f318e3f3e4bcb2e5c587cba756050435
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 265
Content-Type: application/json; charset=utf-8
ETag: W/"db08ee9634db9e8db085074ecaea88bd"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 39af200c-203c-4e1e-9775-63d136f8e610
X-Runtime: 0.065937
X-XSS-Protection: 1; mode=block

[
  {
    "id": 29,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2016-12-26T19:39:10.000+09:00",
    "updated_at": "2016-12-26T19:39:10.000+09:00"
  }
]
```

## POST /api/v1/fetch_messages
Fetch messages whose message id is greater than or equal to offset with HTTP POST method<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100<br/>Returned `resource_time` is in unix timestamp<br/><br/>You can use either of GET /messages or POST /fetch_messages, but note that GET has limitation for query parameters length<br/>

### Example

#### Request
```
POST /api/v1/fetch_messages HTTP/1.1
Accept: application/json
Authorization: 69842d60bc09a94b4eab69451600acc8
Content-Length: 82
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "offset": 30,
  "limit": 100,
  "resource_uris": [
    "hdfs://localhost/path/to/file.csv.gz"
  ]
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 265
Content-Type: application/json; charset=utf-8
ETag: W/"41476a941d19e78b25a60eeefa19c717"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d7ebb98d-729b-4f13-9204-ed2d1b40e16d
X-Runtime: 0.007787
X-XSS-Protection: 1; mode=block

[
  {
    "id": 30,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2016-12-26T19:39:10.000+09:00",
    "updated_at": "2016-12-26T19:39:10.000+09:00"
  }
]
```

## POST /api/v1/messages
Send messages<br/><br/>`resource_time` is in unix timestamp<br/>

### Example

#### Request
```
POST /api/v1/messages HTTP/1.1
Accept: application/json
Authorization: 4ad6cdd4b383007b26a824f32b5787f4
Content-Length: 167
Content-Type: application/json
Host: triglav.analytics.mbga.jp

[
  {
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}"
  }
]
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 17
Content-Type: application/json; charset=utf-8
ETag: W/"782da7bea2c961240e67b304927b4f9f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: ce2f4859-e4e5-4d31-8552-8b84de7e6ac5
X-Runtime: 0.013246
X-XSS-Protection: 1; mode=block

{
  "num_inserts": 1
}
```

## GET /api/v1/messages/last_id
Get last message id which would be used as a first offset to fetch messages<br/>

### Example

#### Request
```
GET /api/v1/messages/last_id HTTP/1.1
Accept: application/json
Authorization: 7e1deddb1849621ac1915ce2ac89d3c5
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 9
Content-Type: application/json; charset=utf-8
ETag: W/"3e0723b4564b84a541d327d01e522d48"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 73960b2c-14b7-4fc5-a792-2608903f10b7
X-Runtime: 0.006394
X-XSS-Protection: 1; mode=block

{
  "id": 32
}
```
