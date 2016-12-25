Triglav
================

Core API and message queue server of Triglav.

# API Spec

[./doc](./doc)

# Requirements

* Ruby >= 2.3.0
* MySQL >= 5.6

# Development

## Prepare

Copy config files and modify them if you want.

```
cp config/database.yml{.development,}
cp config/settings.yml{.development,}
cp config/secrets.yml{.development,}
cp db/seeds.rb{.development,}
```

## Migrate

```
./bin/rails db:create
./bin/rails db:apply # using ridgepole
./bin/rails db:seed
```

## Start

```
bundle exec foreman start
```

## Try

```
$ curl -H "Content-type: application/json" http://localhost:3000/api/v1/auth/token -X POST -d '{"username":"triglav_test", "password": "triglav_test", "authenticator":"local"}'
{"access_token":"xxxxxxxxxxxxxxxxxx","expires_at":1430458696}
```

```
$ curl -H "Content-type: application/json" -H "Authorization: xxxxxxxxxxxxxxxxxx" http://localhost:7800/api/v1/auth/me -X GET
```

# Test

Do migration with `RAILS_ENV=test`, then

```
bundle exec rspec
```

You may generate API doc from requests spec as

```
AUTODOC=1 bundle exec rspec
```

You may run your tests with [spring](https://github.com/rails/spring) to make it faster to finish:

```
bundle exec spring binstubs rspec
bin/rspec
```

# Swagger

We use [swagger](http://swagger.io/) to describe API specification. Write API doc on rails controllers, and serializers referring [Swagger Documentation Specification v2.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).

## Trying with Swaggeer UI

[swagger-ui](https://github.com/swagger-api/swagger-ui) is already bundled. You can start swagger-ui as

```
bundle exec rails s
```

and access to [http://localhost:7800/apidocs](http://localhost:7800/apidocs). By the way, swagger-ui is a full javascript application, so serving this with nginx is also fine.

Authenticate with `POST /auth/token`.

![image](https://cloud.githubusercontent.com/assets/2290461/21415529/0736fb72-c84e-11e6-997f-0c4153352f6b.png)

Click `Try it out!` button, you will get an access token

![image](https://cloud.githubusercontent.com/assets/2290461/21415534/0e0090c6-c84e-11e6-966f-24c843f78679.png)

Go to top bar of Swagger UI, and click `Authorize` button.

![image](https://cloud.githubusercontent.com/assets/2290461/21415537/145e8874-c84e-11e6-9a6e-7ed4aa82df94.png)

Paste your access token to the `value` field, then click Authorize.

![image](https://cloud.githubusercontent.com/assets/2290461/21415538/1889b7c0-c84e-11e6-8d97-2a77e9350b0f.png)

Now, you should be able to hit any APIs.

## Generating Swagger API Specification

To generate a static swagger.json, run

```
bundle exec rake swagger:generate
```

## Generating Swagger API Clients

```
wget http://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.2.0/swagger-codegen-cli-2.2.0.jar -O ~/bin/swagger-codegen-cli.jar
```

Ruby

```
script/swagger-codegen-ruby.sh ../triglav-client-ruby
```

Edit `script/swagger-codegen-ruby.json` for gem version.

Java

```
script/swagger-codegen-java.sh ../triglav-client-java
```

Edit `script/swagger-codegen-java.json` for version.
