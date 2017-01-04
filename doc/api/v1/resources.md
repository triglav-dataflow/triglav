## GET /api/v1/aggregated_resources
Get aggregated resources required to be monitored (i.e., consumable = true and notifiable = false).<br/><br/>`resource_prefix` query parameter is required. Each returned resource has `uri`, `unit`, `timezone`, `span_in_days` parameters. `unit` is `singular` or `daily` or `hourly`, or their combinations such as `daily,hourly` or `daily,hourly,singular`.<br/><br/>FYI: Aggregation is operated as following SQL: `SELECT uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days GROUP BY uri`<br/>

### Example

#### Request
```
GET /api/v1/aggregated_resources?uri_prefix=hdfs://localhost HTTP/1.1
Accept: application/json
Authorization: 826dc974972f2232b3768ed590c34e4a
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
X-Request-Id: 2bc1d59c-2e45-46c6-814d-345436fe761a
X-Runtime: 0.050161
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
Authorization: 02dc1e20aab65b73cb66f81a0253211b
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
X-Request-Id: 5e46146d-82c6-4475-a3b0-1aad1e3ba5f7
X-Runtime: 0.010587
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
GET /api/v1/resources/282 HTTP/1.1
Accept: application/json
Authorization: de98e2af91eaa43c5a24e8f405e849be
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
ETag: W/"f626e14aff79578013bb9629ebd53f16"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f463c979-e288-4e64-a0d9-283181e6205c
X-Runtime: 0.008709
X-XSS-Protection: 1; mode=block

{
  "id": 282,
  "description": "MyString",
  "uri": "hdfs://localhost/aaa.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-01-04T10:26:46.000+09:00",
  "updated_at": "2017-01-04T10:26:46.000+09:00"
}
```

## POST /api/v1/resources
Create a resource

### Example

#### Request
```
POST /api/v1/resources HTTP/1.1
Accept: application/json
Authorization: 8463e8b60ab2eb6d55246b56bb65e1dc
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
ETag: W/"d2b9adc21558559d1c7204e89e1c0767"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: cd96544b-389a-4112-8f01-d63cca3dff7e
X-Runtime: 0.009400
X-XSS-Protection: 1; mode=block

{
  "id": 284,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-01-04T10:26:46.000+09:00",
  "updated_at": "2017-01-04T10:26:46.000+09:00"
}
```

## PUT /api/v1/resources/:resource_id_or_uri
Update a resource

### Example

#### Request
```
PUT /api/v1/resources/285 HTTP/1.1
Accept: application/json
Authorization: 3784c05e479a66a86d03c4dcde7d4fba
Content-Length: 170
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": 285,
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
ETag: W/"a912e2ea8fb71d054456ff7201d99cec"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 2f7f2d77-fc8e-4c02-81eb-eeb7c8330f49
X-Runtime: 0.011057
X-XSS-Protection: 1; mode=block

{
  "id": 285,
  "description": "MyString",
  "uri": "hdfs://localhost/path/to/file.csv.gz",
  "unit": "daily",
  "timezone": "+09:00",
  "span_in_days": 32,
  "consumable": true,
  "notifiable": false,
  "created_at": "2017-01-04T10:26:46.000+09:00",
  "updated_at": "2017-01-04T10:26:46.000+09:00"
}
```

## DELETE /api/v1/resources/:resource_id_or_uri
Delete a resource

### Example

#### Request
```
DELETE /api/v1/resources/287 HTTP/1.1
Accept: application/json
Authorization: ff85989bdc11006afba650d2ec56d3cf
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
X-Request-Id: 8f2e5eac-7fc6-4a63-bcdc-c8af44d12d9e
X-Runtime: 0.032710
X-XSS-Protection: 1; mode=block
```
