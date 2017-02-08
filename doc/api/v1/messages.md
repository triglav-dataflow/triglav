## POST /api/v1/messages
Send messages<br/><br/>`resource_time` is in unix timestamp<br/>

### Example

#### Request
```
POST /api/v1/messages HTTP/1.1
Accept: application/json
Authorization: b721ca156fcdac6cef1fced13ac47f68
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
X-Request-Id: f6e395e5-defc-4a16-a03e-79e9e8cd5907
X-Runtime: 0.120250
X-XSS-Protection: 1; mode=block

{
  "num_inserts": 1
}
```

## GET /api/v1/messages
Fetch messages whose message id is greater than or equal to offset<br/><br/>`offset` is required.<br/>`resource_uris` are optional, but one resource_uri should be set usually.<br/>`limit` is optional, and default is 100.<br/>Returned `resource_time` is in unix timestamp<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=52&resource_uris[]=hdfs://localhost/path/to/file.csv.gz&limit=100 HTTP/1.1
Accept: application/json
Authorization: 58edada9adc4823731a3acff62e2b06a
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
ETag: W/"7aa3f1e35da3888ed0a952e458604fdc"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a69ee1bd-e96c-4b22-8e5a-d2fe7493b69a
X-Runtime: 0.028002
X-XSS-Protection: 1; mode=block

[
  {
    "id": 52,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-02-08T16:51:28.000+09:00",
    "updated_at": "2017-02-08T16:51:28.000+09:00"
  }
]
```

## GET /api/v1/messages/last_id
Get last message id which would be used as a first offset to fetch messages<br/>

### Example

#### Request
```
GET /api/v1/messages/last_id HTTP/1.1
Accept: application/json
Authorization: cd704084360a2bed304807b64e17c942
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
ETag: W/"a2b57f9e7710bb3a13644b3f8e7e2a26"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: edc8ccf4-632d-4f06-abe2-a9c250688cb0
X-Runtime: 0.011538
X-XSS-Protection: 1; mode=block

{
  "id": 53
}
```
