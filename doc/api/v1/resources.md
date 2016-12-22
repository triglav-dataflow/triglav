## GET /api/v1/aggregated_resources
Get aggregated resources required to be monitored (i.e., consumable = true and notifiable = false).<br/><br/>`resource_prefix` query parameter is required. Each returned resource has `uri`, `unit`, `timezone`, `span_in_days` parameters. Note that the `unit` paramter would be `daily,hourly` in addition to `hourly`, `daily`.<br/><br/>FYI: Aggregation is operated as following SQL: `SELECT uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days GROUP BY uri`<br/>

### Example

#### Request
```
GET /api/v1/aggregated_resources?uri_prefix=hdfs://localhost HTTP/1.1
Accept: application/json
Authorization: ee5f61b0843989203187e40210851386
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 190
Content-Type: application/json; charset=utf-8
ETag: W/"79d1aaf9b1b11e2f2dfe720e77957593"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7582a415-5e40-420c-8b5f-679b0c5d6dd0
X-Runtime: 0.051705
X-XSS-Protection: 1; mode=block

[
  {
    "uri": "hdfs://localhost/aaa.csv.gz",
    "unit": "daily,hourly",
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
Authorization: 169dd3b38b9d692ba07aa1f1abc86805
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 770
Content-Type: application/json; charset=utf-8
ETag: W/"22f1d28635b1a79546858e351068eb44"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 154c2202-4335-4cd1-a009-607bed6e9b45
X-Runtime: 0.011445
X-XSS-Protection: 1; mode=block

[
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
GET /api/v1/resources/273 HTTP/1.1
Accept: application/json
Authorization: 4cfae14e4171a5e03e93d10b0f8c21bf
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
ETag: W/"9bc93a7476c8e9caea1bae864aaf4680"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 92e33a33-ed9b-4547-9962-99bf300dea89
X-Runtime: 0.010178
X-XSS-Protection: 1; mode=block

{
  "id": 273,
  "description": "MyString",
  "uri": "hdfs://localhost/aaa.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2016-12-16T20:40:48.000+09:00",
  "updated_at": "2016-12-16T20:40:48.000+09:00"
}
```

## POST /api/v1/resources
Create a resource

### Example

#### Request
```
POST /api/v1/resources HTTP/1.1
Accept: application/json
Authorization: 41b0952fd36f505d65874be910c34a6c
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
ETag: W/"25fd71376669d6fef029f224702e00e1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c7f8cfa6-bf82-46c8-93c9-28928051fda7
X-Runtime: 0.010359
X-XSS-Protection: 1; mode=block

{
  "id": 275,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2016-12-16T20:40:48.000+09:00",
  "updated_at": "2016-12-16T20:40:48.000+09:00"
}
```

## PUT /api/v1/resources/:resource_id_or_uri
Update a resource

### Example

#### Request
```
PUT /api/v1/resources/276 HTTP/1.1
Accept: application/json
Authorization: 6e9cdfac15c78d07fa1b2da9ed048547
Content-Length: 170
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": 276,
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
ETag: W/"f307e9f75857bfd92f7fdff8cb959491"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 4a3a333f-37f7-49c9-af10-2029054e5801
X-Runtime: 0.009258
X-XSS-Protection: 1; mode=block

{
  "id": 276,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2016-12-16T20:40:48.000+09:00",
  "updated_at": "2016-12-16T20:40:48.000+09:00"
}
```

## DELETE /api/v1/resources/:resource_id_or_uri
Delete a resource

### Example

#### Request
```
DELETE /api/v1/resources/278 HTTP/1.1
Accept: application/json
Authorization: fcdb0283a580bd447d133dbad2ef01ed
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
X-Request-Id: 1c82fcd2-c4b7-4518-bd39-fe5c751497c3
X-Runtime: 0.007772
X-XSS-Protection: 1; mode=block
```
