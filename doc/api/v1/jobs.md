## PUT /api/v1/jobs
Create or update a job along with creating or updating resources.<br/><br/>Create a job if its id is not given, and update a job if its id is given.<br/>Create resources if ids are not given for input and output resources, and update resources if ids are given for input and output resources. Destroy resources if ids of existing resources are not givens.<br/><br/>`span_in_days` is optional, and automatically filled with default value for both input and output resources.<br/>`consumable` for input resources are automatically set to true because this job will consume events for the input resource.<br/>`notifiable` for output resources should be set to 'true' only if the registered job will notify the end of job to triglav (i.e, send messages directly without triglav agent).<br/>

### Example

#### Request
```
PUT /api/v1/jobs HTTP/1.1
Accept: application/json
Authorization: 41b4213a7373358242e1c3a4d8cded19
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
Content-Length: 1180
Content-Type: application/json; charset=utf-8
ETag: W/"5f9e29e3fe98a05e990a08ade1ffa178"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 273d1cdb-3af8-4de3-9bbe-f0480eb41248
X-Runtime: 0.158494
X-XSS-Protection: 1; mode=block

{
  "id": 28,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T16:24:25.000+09:00",
  "updated_at": "2017-02-08T16:24:25.000+09:00",
  "input_resources": [
    {
      "id": 94,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    },
    {
      "id": 95,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 96,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    },
    {
      "id": 97,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": true,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
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
Authorization: 37ae5990b25d709929a5e8daced08340
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
ETag: W/"3e8bae54ff5263633c944b5b6a685b0d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a0c1fa9d-9a8f-4a67-8957-8e2a3f913880
X-Runtime: 0.022072
X-XSS-Protection: 1; mode=block

{
  "id": 31,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T16:24:25.000+09:00",
  "updated_at": "2017-02-08T16:24:25.000+09:00",
  "input_resources": [
    {
      "id": 106,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    },
    {
      "id": 107,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 108,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    },
    {
      "id": 109,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:24:25.000+09:00",
      "updated_at": "2017-02-08T16:24:25.000+09:00"
    }
  ]
}
```

## DELETE /api/v1/jobs/:job_id
Delete a job

### Example

#### Request
```
DELETE /api/v1/jobs/32 HTTP/1.1
Accept: application/json
Authorization: 55edd92f9f48f7a9043b076ef55a040a
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
X-Request-Id: 9eb3c03e-3ba0-410d-b04f-3b3a15997197
X-Runtime: 0.022334
X-XSS-Protection: 1; mode=block
```
