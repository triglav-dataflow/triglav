## GET /api/v1/messages
Fetch messages whose message id is greater than or equal to offset<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100.<br/>Returned `resource_time` is in unix timestamp<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=48&limit=100 HTTP/1.1
Accept: application/json
Authorization: f0327558e021f18896c1d6662f532e46
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
ETag: W/"af9d7f3c3a963c5e71c1a46d9b2a0838"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 34578e15-2455-4480-a26a-d75eb4eb193e
X-Runtime: 0.022543
X-XSS-Protection: 1; mode=block

[
  {
    "id": 48,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-02-08T16:37:08.000+09:00",
    "updated_at": "2017-02-08T16:37:08.000+09:00"
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
Authorization: 08377a8d5b1a1b88d5a806e47c86455c
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
X-Request-Id: f506705a-bae6-484b-bc82-a59b25bf6c88
X-Runtime: 0.012144
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
Authorization: e649c037f8a3ddc7bb397dbc0a2fcda0
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
ETag: W/"94c774110436cc0702b7e7565d565061"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 9ecd92ec-d771-4664-a1d6-ecdcfa8e066a
X-Runtime: 0.005511
X-XSS-Protection: 1; mode=block

{
  "id": 50
}
```
