## PUT /api/v1/jobs
Create or update a job along with creating or updating resources.<br/><br/>Create a job if its id is not given, and update a job if its id is given.<br/>Create resources if ids are not given for input and output resources, and update resources if ids are given for input and output resources. Destroy resources if ids of existing resources are not givens.<br/><br/>`span_in_days` is optional, and automatically filled with default value for both input and output resources.<br/>`consumable` for input resources are automatically set to true because this job will consume events for the input resource.<br/>`notifiable` for output resources should be set to 'true' only if the registered job will notify the end of job to triglav (i.e, send messages directly without triglav agent).<br/>

### Example

#### Request
```
PUT /api/v1/jobs HTTP/1.1
Accept: application/json
Authorization: d9fe1bfb0638da7a3e9045c9c0ff2cd1
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
ETag: W/"69587e98e27b6cf9c02a35182817929f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: db792301-2865-4318-89ff-1f712d051990
X-Runtime: 0.126630
X-XSS-Protection: 1; mode=block

{
  "id": 51,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T16:37:07.000+09:00",
  "updated_at": "2017-02-08T16:37:07.000+09:00",
  "input_resources": [
    {
      "id": 175,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:07.000+09:00",
      "updated_at": "2017-02-08T16:37:07.000+09:00"
    },
    {
      "id": 176,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:07.000+09:00",
      "updated_at": "2017-02-08T16:37:07.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 177,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:07.000+09:00",
      "updated_at": "2017-02-08T16:37:07.000+09:00"
    },
    {
      "id": 178,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": true,
      "created_at": "2017-02-08T16:37:07.000+09:00",
      "updated_at": "2017-02-08T16:37:07.000+09:00"
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
Authorization: 1132601c472a9f99b1253aabfa5224fc
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
ETag: W/"93cf7ca52db5998385cdf58f77be021d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8e4daa7c-bda3-4522-ab06-c215a5c0de51
X-Runtime: 0.015498
X-XSS-Protection: 1; mode=block

{
  "id": 54,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2017-02-08T16:37:08.000+09:00",
  "updated_at": "2017-02-08T16:37:08.000+09:00",
  "input_resources": [
    {
      "id": 187,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:08.000+09:00",
      "updated_at": "2017-02-08T16:37:08.000+09:00"
    },
    {
      "id": 188,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:08.000+09:00",
      "updated_at": "2017-02-08T16:37:08.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 189,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:08.000+09:00",
      "updated_at": "2017-02-08T16:37:08.000+09:00"
    },
    {
      "id": 190,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2017-02-08T16:37:08.000+09:00",
      "updated_at": "2017-02-08T16:37:08.000+09:00"
    }
  ]
}
```

## DELETE /api/v1/jobs/:job_id
Delete a job

### Example

#### Request
```
DELETE /api/v1/jobs/55 HTTP/1.1
Accept: application/json
Authorization: 0535a4ec2cd07301049bfa729b3a3e59
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
X-Request-Id: eaaed296-1954-4d37-a11a-fc43c26d6c1b
X-Runtime: 0.019311
X-XSS-Protection: 1; mode=block
```
