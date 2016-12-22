## PUT /api/v1/jobs
Create or update a job along with creating or updating resources.<br/><br/>Create a job if its id is not given, and update a job if its id is given.<br/>Create resources if ids are not given for input and output resources, and update resources if ids are given for input and output resources. Destroy resources if ids of existing resources are not givens.<br/><br/>`span_in_days` is optional, and automatically filled with default value for both input and output resources.<br/>`consumable` for input resources are automatically set to true because this job will consume events for the input resource.<br/>`notifiable` for output resources should be set to 'true' only if the registered job will notify the end of job to triglav (i.e, send messages directly without triglav agent).<br/>

### Example

#### Request
```
PUT /api/v1/jobs HTTP/1.1
Accept: application/json
Authorization: cd07302994753896695ba0198588c4e3
Content-Length: 516
Content-Type: application/json
Host: triglav.analytics.mbga.jp

{
  "id": null,
  "uri": "http://localhost/path/to/job?query=parameter",
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
ETag: W/"b90ebcdb5e6be3b81a411be958b72fbf"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f8a435da-786d-4683-8558-2509e5c55795
X-Runtime: 0.144283
X-XSS-Protection: 1; mode=block

{
  "id": 36,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2016-12-16T20:48:19.000+09:00",
  "updated_at": "2016-12-16T20:48:19.000+09:00",
  "input_resources": [
    {
      "id": 296,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:19.000+09:00",
      "updated_at": "2016-12-16T20:48:19.000+09:00"
    },
    {
      "id": 297,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 298,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    },
    {
      "id": 299,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": false,
      "notifiable": true,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
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
Authorization: 1a9b32aca8639a759ba2673973d01915
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
ETag: W/"4a7c2cefdf7709efb8ef8baf335f9d95"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 43d48e32-a398-46de-946d-0ff47adc37c7
X-Runtime: 0.016580
X-XSS-Protection: 1; mode=block

{
  "id": 39,
  "uri": "http://localhost/path/to/job?query=parameter",
  "created_at": "2016-12-16T20:48:20.000+09:00",
  "updated_at": "2016-12-16T20:48:20.000+09:00",
  "input_resources": [
    {
      "id": 308,
      "description": "MyString",
      "uri": "resource://input/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    },
    {
      "id": 309,
      "description": "MyString",
      "uri": "resource://input/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    }
  ],
  "output_resources": [
    {
      "id": 310,
      "description": "MyString",
      "uri": "resource://output/uri/0",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    },
    {
      "id": 311,
      "description": "MyString",
      "uri": "resource://output/uri/1",
      "unit": "daily",
      "timezone": "+09:00",
      "span_in_days": 32,
      "consumable": true,
      "notifiable": false,
      "created_at": "2016-12-16T20:48:20.000+09:00",
      "updated_at": "2016-12-16T20:48:20.000+09:00"
    }
  ]
}
```

## DELETE /api/v1/jobs/:job_id
Delete a job

### Example

#### Request
```
DELETE /api/v1/jobs/40 HTTP/1.1
Accept: application/json
Authorization: 1973c3beed33ac925d91115d46617209
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
X-Request-Id: 0356c3e7-09f8-46dd-86ef-a3b05363e68b
X-Runtime: 0.017168
X-XSS-Protection: 1; mode=block
```
