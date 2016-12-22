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

Copy config files and modify config files if you want.

```
cp config/database.yml{.development,}
cp config/settings.yml{.development,}
cp config/secrets.yml{.development,}
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

![image](https://github.dena.jp/github-enterprise-assets/0000/0795/0001/7644/5443f55c-8c1a-11e6-810b-58885c8d7aed.png)

Click `Try it out!` button, you will get an access token

![image](https://github.dena.jp/github-enterprise-assets/0000/0795/0001/7645/e1af3dca-8c1a-11e6-9da2-617d1ccd40c7.png)

Go to top bar of Swagger UI, and click `Authorize` button.

![image](https://github.dena.jp/github-enterprise-assets/0000/0795/0001/7646/f353f9a8-8c1a-11e6-9efe-085332a32d4e.png)

Paste your access token to the `value` field, then click Authorize.

![image](https://github.dena.jp/github-enterprise-assets/0000/0795/0001/7647/0463424e-8c1b-11e6-8dba-e0124bb9f516.png)

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
