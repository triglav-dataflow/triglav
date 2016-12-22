#!/bin/bash
# Usage: script/swagger-codegen-java.sh /path/to/triglav-client-java/codegen

APP_ROOT=$(cd $(dirname $0);cd ..;pwd)
OUTPUT="$APP_ROOT/../triglav-client-java"
if [ -n "$1" ]; then
  OUTPUT=$1
fi

bundle exec rails swagger:generate

java -jar ~/bin/swagger-codegen-cli.jar generate \
  -i $APP_ROOT/tmp/swagger.json \
  -l java \
  -c $APP_ROOT/script/swagger-codegen-java.json \
  -o $OUTPUT

cd $OUTPUT && ./gradlew build
