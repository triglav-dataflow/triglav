## GET /api/v1/messages
List messages whose message id is greater than or equal to offset with HTTP GET method<br/><br/>`offset`, `resource_uris` are required<br/>`limit` is optional, and default is 100<br/>Returned `resource_time` is in unix timestamp<br/>

### Example

#### Request
```
GET /api/v1/messages?offset=22&limit=100&resource_uris[]=hdfs://localhost/path/to/file.csv.gz HTTP/1.1
Accept: application/json
Authorization: e0da6a1108290c12aab91a73ce115164
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
ETag: W/"dd1cf3cdcd602830eadb8e7e3e5c467c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 9c810def-b416-46d5-a8e0-1db0214156eb
X-Runtime: 0.058535
X-XSS-Protection: 1; mode=block

[
  {
    "id": 22,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2016-12-16T20:44:44.000+09:00",
    "updated_at": "2016-12-16T20:44:44.000+09:00"
  }
]
```

## POST /api/v1/fetch_messages
Fetch messages whose message id is greater than or equal to offset with HTTP POST method<br/><br/>`offset`, `resource_uris` are required<br/>`limit` is optional, and default is 100<br/>Returned `resource_time` is in unix timestamp<br/>

### Example

#### Request
```
POST /api/v1/fetch_messages HTTP/1.1
Accept: application/json
Authorization: d84affe9a0dc34d53b51baa0dd8005f1
Content-Length: 82
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "offset": 23,
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
ETag: W/"fac5ba793c915fb0a22aebdb36dce16f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5b0e4723-0fc7-44b3-bbdb-e3fbf5a1cec9
X-Runtime: 0.006812
X-XSS-Protection: 1; mode=block

[
  {
    "id": 23,
    "resource_uri": "hdfs://localhost/path/to/file.csv.gz",
    "resource_unit": "daily",
    "resource_time": 1467298800,
    "resource_timezone": "+09:00",
    "payload": "{\"foo\":\"bar\"}",
    "created_at": "2016-12-16T20:44:44.000+09:00",
    "updated_at": "2016-12-16T20:44:44.000+09:00"
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
Authorization: ca519eb71853ea597e11816bbee8df73
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
X-Request-Id: e25d6f82-edaf-4889-b9df-1986c4b829ea
X-Runtime: 0.022850
X-XSS-Protection: 1; mode=block

{
  "num_inserts": 1
}
```
