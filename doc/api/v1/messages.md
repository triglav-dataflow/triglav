## GET /api/v1/messages
List messages whose message id is greater than or equal to offset with HTTP GET method<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100.<br/>`resource_unit` is optional, but required if `resource_time` is given.<br/>`resource_time` is optional.<br/>Returned `resource_time` is in unix timestamp<br/><br/>You can use either of GET /messages or POST /fetch_messages, but note that GET has limitation for query parameters length<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=11&limit=100&resource_uris[]=hdfs://localhost/path/to/file.csv.gz&resource_unit=daily&resource_time=1467298800 HTTP/1.1
Accept: application/json
Authorization: 5489933ddcec13ed354db594dc614e1a
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
ETag: W/"a6893623161268b665d040cafe09d8db"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 20d3b0eb-e7bc-459b-88e1-8a692ca86fe4
X-Runtime: 0.049367
X-XSS-Protection: 1; mode=block

[
  {
    "id": 11,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-01-10T14:21:08.000+09:00",
    "updated_at": "2017-01-10T14:21:08.000+09:00"
  }
]
```

## POST /api/v1/fetch_messages
Fetch messages whose message id is greater than or equal to offset with HTTP POST method<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100<br/>`resource_unit` is optional, but required if `resource_time` is given.<br/>`resource_time` is optional.<br/>Returned `resource_time` is in unix timestamp<br/><br/>You can use either of GET /messages or POST /fetch_messages, but note that GET has limitation for query parameters length<br/>

### Example

#### Request
```
POST /api/v1/fetch_messages HTTP/1.1
Accept: application/json
Authorization: 27d94d345c121686423396bd0fd19a7f
Content-Length: 133
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "offset": 12,
  "limit": 100,
  "resource_uris": [
    "hdfs://localhost/path/to/file.csv.gz"
  ],
  "resource_unit": "daily",
  "resource_time": 1467298800
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 265
Content-Type: application/json; charset=utf-8
ETag: W/"f25d17ff2119565c6ff0dea0f8e0381d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: bb0b93c5-2f27-4b0c-aace-141d51263e04
X-Runtime: 0.007134
X-XSS-Protection: 1; mode=block

[
  {
    "id": 12,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-01-10T14:21:08.000+09:00",
    "updated_at": "2017-01-10T14:21:08.000+09:00"
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
Authorization: af7ed3071b6e87b0cce5cfeb44a7bcad
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
X-Request-Id: 4a7921c9-25f2-448e-879f-623381fedfbb
X-Runtime: 0.013286
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
Authorization: 2593eed4fe684f3b9cc877fff9b84fb0
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
ETag: W/"04d7a82c013ba361d4d35261866fe98f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 372f2a38-2b63-4af1-85f6-ad8763945a62
X-Runtime: 0.005657
X-XSS-Protection: 1; mode=block

{
  "id": 14
}
```
