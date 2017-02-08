#!/bin/bash -eu
# Usage: script/swagger-codegen-ruby.sh /path/to/triglav-client-ruby/codegen

APP_ROOT=$(cd "$(dirname "$0")";cd ..;pwd)
OUTPUT="$APP_ROOT/../triglav-client-ruby"
if [ $# -ge 1 ]; then
  OUTPUT=$1
fi

bundle exec rails swagger:generate

java -jar ~/bin/swagger-codegen-cli.jar generate \
  -i "$APP_ROOT"/tmp/swagger.json \
  -l ruby \
  -c "$APP_ROOT"/script/swagger-codegen-ruby.json \
  -o "$OUTPUT"
