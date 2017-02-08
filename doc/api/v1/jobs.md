## PUT /api/v1/jobs
Create or update a job along with creating or updating resources.<br/><br/>Create a job if its id is not given, and update a job if its id is given.<br/>Create resources if ids are not given for input and output resources, and update resources if ids are given for input and output resources. Destroy resources if ids of existing resources are not givens.<br/><br/>`logical_op` is optional (default is `or`). With `and`, a job_message event is fired if all input resources' events are set. With `or`, a job_message event is fired if one of input resources' event is set.<br/>`span_in_days` is optional, and automatically filled with default value for both input and output resources.<br/>`consumable` for input resources are automatically set to true because this job will consume events for the input resource.<br/>`notifiable` for output resources should be set to 'true' only if the registered job will notify the end of job to triglav (i.e, send messages directly without triglav agent).<br/>

### Example

#### Request
```
PUT /api/v1/jobs HTTP/1.1
Accept: application/json
Authorization: ecd02f191e6a7d619ed3ed1bdacf7c86
Content-Length: 534
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": null,
  "uri": "http://localhost/path/to/job?query=parameter",
  "logical_op": "or",
  "input_resources": [
    {
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00"
    },
    {
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00"
    }
  ],
  "output_resources": [
    {
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "notifiable": false
    },
    {
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "notifiable": true
    }
  ]
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 1184
Content-Type: application/json; charset=utf-8
ETag: W/"49cce78b66f90852020254cd58b03fc1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e3b875bb-51db-47e3-99a0-db28b9eb0e89
X-Runtime: 0.200045
X-XSS-Protection: 1; mode=block

{
  "id": 56,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T17:01:50.000+09:00",
  "updated_at": "2017-02-08T17:01:50.000+09:00",
  "input_resources": [
    {
      "id": 212,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    },
    {
      "id": 213,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 214,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    },
    {
      "id": 215,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": true,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    }
  ]
}
```

## GET /api/v1/jobs/:id_or_uri
Get a job<br/>

### Example

#### Request
```
GET /api/v1/jobs/http%3A%2F%2Flocalhost%2Fpath%2Fto%2Fjob%3Fquery%3Dparameter HTTP/1.1
Accept: application/json
Authorization: 48ce42a680e520462a224506d3ada2da
Content-Length: 0
Content-Type: application/json
Host: triglav.analytics.mbga.jp
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 1183
Content-Type: application/json; charset=utf-8
ETag: W/"ca9b6f0cb7838b894e68c5681ab54dbd"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 87ee68a6-8f7a-458b-ab22-ab82b8f3c958
X-Runtime: 0.018125
X-XSS-Protection: 1; mode=block

{
  "id": 59,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T17:01:50.000+09:00",
  "updated_at": "2017-02-08T17:01:50.000+09:00",
  "input_resources": [
    {
      "id": 224,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    },
    {
      "id": 225,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 226,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    },
    {
      "id": 227,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T17:01:50.000+09:00",
      "updated_at": "2017-02-08T17:01:50.000+09:00"
    }
  ]
}
```

## DELETE /api/v1/jobs/:job_id
Delete a job

### Example

#### Request
```
DELETE /api/v1/jobs/60 HTTP/1.1
Accept: application/json
Authorization: f10fbcaba6a6f8a48f4592a3f14972fd
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
X-Request-Id: b89d071d-33b8-42eb-b791-34c8d7cd5a84
X-Runtime: 0.021297
X-XSS-Protection: 1; mode=block
```
