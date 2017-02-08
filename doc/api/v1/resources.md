## GET /api/v1/aggregated_resources
Get aggregated resources required to be monitored (i.e., consumable = true and notifiable = false).<br/><br/>`resource_prefix` query parameter is required. Each returned resource has `uri`, `unit`, `timezone`, `span_in_days` parameters. `unit` is `singular` or `daily` or `hourly`, or their combinations such as `daily,hourly` or `daily,hourly,singular`.<br/><br/>FYI: Aggregation is operated as following SQL: `SELECT uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days GROUP BY uri`<br/>

### Example

#### Request
```
GET /api/v1/aggregated_resources?uri_prefix=hdfs://localhost HTTP/1.1
Accept: application/json
Authorization: 31fc848fdaeb2441befb24d535ce45b0
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 199
Content-Type: application/json; charset=utf-8
ETag: W/"9a3d4c5329bde6ef217bf86390886968"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6ea21cc5-afa0-4904-9738-d2c795891482
X-Runtime: 0.024649
X-XSS-Protection: 1; mode=block

[
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "daily,hourly,singular",
    "timezone": "+09:00",
    "span_in_days": 48
  },
  {
    "uri": "hdfs://localhost/bbb.csv.gz",
    "unit": "daily",
    "timezone": "+09:00",
    "span_in_days": 32
  }
]
```

## GET /api/v1/resources
Get resource index<br/>

### Example

#### Request
```
GET /api/v1/resources?uri_prefix=hdfs://localhost HTTP/1.1
Accept: application/json
Authorization: f10be16c1dd7792fb9035ecb32afbb13
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 901
Content-Type: application/json; charset=utf-8
ETag: W/"241499a51f690e3c48845461c5b66a19"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d43b893f-e524-4ebe-a7c3-aa000a0196e1
X-Runtime: 0.012799
X-XSS-Protection: 1; mode=block

[
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "singular",
    "timezone": "+09:00",
    "span_in_days": 32,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "daily",
    "timezone": "+09:00",
    "span_in_days": 32,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "hourly",
    "timezone": "+09:00",
    "span_in_days": 16,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "hourly",
    "timezone": "+09:00",
    "span_in_days": 48,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/bbb.csv.gz",
    "unit": "daily",
    "timezone": "+09:00",
    "span_in_days": 32,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/ccc.csv.gz",
    "unit": "daily",
    "timezone": "+09:00",
    "span_in_days": 32,
    "consumable": true,
    "notifiable": false
  },
  {
    "uri": "hdfs://localhost/ccc.csv.gz",
    "unit": "daily",
    "timezone": "+09:00",
    "span_in_days": 32,
    "consumable": true,
    "notifiable": true
  }
]
```

## GET /api/v1/resources/:resource_id_or_uri
Get a resource

### Example

#### Request
```
GET /api/v1/resources/124 HTTP/1.1
Accept: application/json
Authorization: 8768f70f0a7caf3bfd43c027aa223cd4
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 251
Content-Type: application/json; charset=utf-8
ETag: W/"b19bc191bcd15299107b491858022dc3"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 840ffda2-c340-499e-946e-17632b8d3787
X-Runtime: 0.008493
X-XSS-Protection: 1; mode=block

{
  "id": 124,
  "description": "MyString",
  "uri": "hdfs://localhost/aaa.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## POST /api/v1/resources
Create a resource

### Example

#### Request
```
POST /api/v1/resources HTTP/1.1
Accept: application/json
Authorization: 2977dd1fc9ce31d9dfeb5dc5aeddbd4f
Content-Length: 173
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": null,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": null,
  "consumable": true,
  "notifiable": false
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 260
Content-Type: application/json; charset=utf-8
ETag: W/"b84874134726b61a6f1a1773fa129b75"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 2b05b8a1-5929-4e13-a4cf-ae4742a80045
X-Runtime: 0.012610
X-XSS-Protection: 1; mode=block

{
  "id": 126,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## PUT /api/v1/resources/:resource_id_or_uri
Update a resource

### Example

#### Request
```
PUT /api/v1/resources/127 HTTP/1.1
Accept: application/json
Authorization: 63d6cf2fb1c19864e5e92ebd80ccd701
Content-Length: 170
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": 127,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 260
Content-Type: application/json; charset=utf-8
ETag: W/"abf514e15549692aa4133bbcba28ef58"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 667e5ffc-07b5-4b36-be60-4af681d1d136
X-Runtime: 0.012930
X-XSS-Protection: 1; mode=block

{
  "id": 127,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:24:26.000+09:00",
  "updated_at": "2017-02-08T16:24:26.000+09:00"
}
```

## DELETE /api/v1/resources/:resource_id_or_uri
Delete a resource

### Example

#### Request
```
DELETE /api/v1/resources/129 HTTP/1.1
Accept: application/json
Authorization: 639d477c7011844debe2d22ed4296bb4
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
X-Request-Id: 438e53d7-82c1-42bd-8c37-ec3ff9a19928
X-Runtime: 0.023694
X-XSS-Protection: 1; mode=block
```
