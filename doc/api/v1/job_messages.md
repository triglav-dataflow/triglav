## GET /api/v1/job_messages
Fetch job-messages whose message id is greater than or equal to offset<br/><br/>`offset` is required.<br/>`job_id` is required.<br/>`limit` is optional, and default is 100.<br/>Returned `time` is in unix timestamp of returned `timestamp`.<br/>

### Example

#### Request
```
GET /api/v1/job_messages?offset=61&job_id=1&limit=100 HTTP/1.1
Accept: application/json
Authorization: 9e3e8ae0bd56d9c7175a173ceb853c38
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 60
Content-Type: application/json; charset=utf-8
ETag: W/"33bba9ac6e9691f8e7b37216562339b2"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 9285f081-aa2c-4866-b7ab-662308e45b49
X-Runtime: 0.022615
X-XSS-Protection: 1; mode=block

[
  {
    "id": 61,
    "job_id": 1,
    "time": 1467298800,
    "timezone": "+09:00"
  }
]
```

## GET /api/v1/job_messages/last_id
Get last AND message id which would be used as a first offset to fetch messages<br/>

### Example

#### Request
```
GET /api/v1/job_messages/last_id HTTP/1.1
Accept: application/json
Authorization: 8254536798a88899c41010394b1a458a
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 8
Content-Type: application/json; charset=utf-8
ETag: W/"f0d9dc55adf56c34697a435bff3e62db"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: be7192a7-3bba-44bc-b0a0-d22dc7592a78
X-Runtime: 0.010322
X-XSS-Protection: 1; mode=block

{
  "id": 0
}
```
