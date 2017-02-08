## GET /api/v1/messages
Fetch messages whose message id is greater than or equal to offset<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100.<br/>Returned `resource_time` is in unix timestamp<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=33&limit=100 HTTP/1.1
Accept: application/json
Authorization: b29d55cc69b4e05ae49bd5a53a6669b1
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
ETag: W/"f0fbef3a41a7a7d06aa5c48ac6438cdc"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: fe86a1e7-e6db-4349-8ab8-aeb994a3110a
X-Runtime: 0.024961
X-XSS-Protection: 1; mode=block

[
  {
    "id": 33,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-02-08T16:24:25.000+09:00",
    "updated_at": "2017-02-08T16:24:25.000+09:00"
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
Authorization: 624750f977b3bcef61bc2d2a11f9cf39
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
X-Request-Id: 97b8aeeb-6886-4fa5-becf-6dd174de9d1d
X-Runtime: 0.015668
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
Authorization: 6750f288d59f76f6820c03d962cb8427
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
ETag: W/"ceca09ccd6a719f58b6024acc5bf6ebc"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 693bd7c4-2aae-4fec-91ba-8bbe3bde791e
X-Runtime: 0.007314
X-XSS-Protection: 1; mode=block

{
  "id": 35
}
```
