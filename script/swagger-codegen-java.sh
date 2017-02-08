#!/bin/bash -eu
# Usage: script/swagger-codegen-java.sh /path/to/triglav-client-java/codegen

APP_ROOT=$(cd "$(dirname "$0")";cd ..;pwd)
OUTPUT="$APP_ROOT/../triglav-client-java"
if [ $# -ge 1 ]; then
  OUTPUT="$1"
fi

bundle exec rails swagger:generate

"rm" -f "$OUTPUT"/LICENSE
"rm" -f "$OUTPUT"/README.md
"rm" -f "$OUTPUT"/build.gradle
"rm" -f "$OUTPUT"/build.sbt
"rm" -f "$OUTPUT"/git_push.sh
"rm" -f "$OUTPUT"/gradle.properties
"rm" -f "$OUTPUT"/gradlew.bat
"rm" -f "$OUTPUT"/pom.xml
"rm" -f "$OUTPUT"/settings.gradle

java -jar ~/bin/swagger-codegen-cli.jar generate \
  -i "$APP_ROOT"/tmp/swagger.json \
  -l java \
  -c "$APP_ROOT"/script/swagger-codegen-java.json \
  -o "$OUTPUT"

cd "$OUTPUT" && ./gradlew build
