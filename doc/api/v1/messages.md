## POST /api/v1/messages
Send messages<br/><br/>`resource_time` is in unix timestamp<br/>

### Example

#### Request
```
POST /api/v1/messages HTTP/1.1
Accept: application/json
Authorization: 543a831e8a5a395096faa409af60aeeb
Content-Length: 213
Content-Type: application/json
Host: triglav.analytics.mbga.jp

[
  {
    "uuid": "4f5906b5-c8cf-4585-b011-b4da25b5468d",
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
X-Request-Id: 253e1f72-0ae2-49eb-9253-d85155a6242d
X-Runtime: 0.068358
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
GET /api/v1/messages?offset=122&resource_uris[]=hdfs://localhost/path/to/file.csv.gz&limit=100 HTTP/1.1
Accept: application/json
Authorization: 873b6a5333e2126d26410750f5605067
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 266
Content-Type: application/json; charset=utf-8
ETag: W/"16018af8b89c8a92167904afae2f5c8b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0ac5159e-2472-40fc-b78b-c1e32f892776
X-Runtime: 0.023866
X-XSS-Protection: 1; mode=block

[
  {
    "id": 122,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2017-02-20T12:14:59.000+09:00",
    "updated_at": "2017-02-20T12:14:59.000+09:00"
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
Authorization: de1d7cd1a4c8479e90da99504ce016aa
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 10
Content-Type: application/json; charset=utf-8
ETag: W/"185a5203b0ed48bd8b816a8355aa98bc"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 07d1a9f6-0ae6-43aa-a822-234b0cf65278
X-Runtime: 0.006239
X-XSS-Protection: 1; mode=block

{
  "id": 123
}
```
