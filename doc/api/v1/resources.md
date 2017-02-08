## GET /api/v1/aggregated_resources
Get aggregated resources required to be monitored (i.e., consumable = true and notifiable = false).<br/><br/>`resource_prefix` query parameter is required. Each returned resource has `uri`, `unit`, `timezone`, `span_in_days` parameters. `unit` is `singular` or `daily` or `hourly`, or their combinations such as `daily,hourly` or `daily,hourly,singular`.<br/><br/>FYI: Aggregation is operated as following SQL: `SELECT uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days GROUP BY uri`<br/>

### Example

#### Request
```
GET /api/v1/aggregated_resources?uri_prefix=hdfs://localhost HTTP/1.1
Accept: application/json
Authorization: 9b3ff44e13bfa5f0dd141ac4c58786ef
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
X-Request-Id: d0a1a92e-5d31-4dc0-925e-23ad262733a3
X-Runtime: 0.021252
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
Authorization: 5cf757cfde61c83060c56cba312cb1e2
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
X-Request-Id: 66c58ea7-c308-4fbe-bf87-7ffa30c77274
X-Runtime: 0.011447
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
GET /api/v1/resources/205 HTTP/1.1
Accept: application/json
Authorization: 27b9d914eb4aecdf1fcd77d5dbcf3850
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
ETag: W/"e4aa5725c683e5416e6fbe06939c6d75"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: dd4f4b8c-374c-48ca-bafc-ce57fb4cb681
X-Runtime: 0.007053
X-XSS-Protection: 1; mode=block

{
  "id": 205,
  "description": "MyString",
  "uri": "hdfs://localhost/aaa.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00"
}
```

## POST /api/v1/resources
Create a resource

### Example

#### Request
```
POST /api/v1/resources HTTP/1.1
Accept: application/json
Authorization: 0379cc7aad39738564c40d892036de40
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
ETag: W/"99bc452b47ad9555516a3070ad6400e2"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 73edc257-7967-47b3-a90f-f151e250203f
X-Runtime: 0.010569
X-XSS-Protection: 1; mode=block

{
  "id": 207,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00"
}
```

## PUT /api/v1/resources/:resource_id_or_uri
Update a resource

### Example

#### Request
```
PUT /api/v1/resources/208 HTTP/1.1
Accept: application/json
Authorization: 3d4fca143cfe7e479eee8626e08f32c7
Content-Length: 170
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": 208,
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
ETag: W/"cc0c0f5ad226c9e39d9dee1104128cba"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d921e7e3-9d45-4483-9c63-22dbc3e8edc8
X-Runtime: 0.009994
X-XSS-Protection: 1; mode=block

{
  "id": 208,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00"
}
```

## DELETE /api/v1/resources/:resource_id_or_uri
Delete a resource

### Example

#### Request
```
DELETE /api/v1/resources/210 HTTP/1.1
Accept: application/json
Authorization: f86e23db3eccf828afe61f552333cc06
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
X-Request-Id: 4144d2a6-5a60-42e3-98cb-2b6f8ae4bc60
X-Runtime: 0.014809
X-XSS-Protection: 1; mode=block
```
