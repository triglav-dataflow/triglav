#!/bin/sh
ABSPATH=$(cd $(dirname $0) && pwd)/$(basename $0)
APP_ROOT=$(dirname $ABSPATH)

if [ -z "$PORT" ]; then
  PORT=7800
fi

cd $APP_ROOT
mkdir -p tmp/pids
mkdir -p log

exec bundle exec start_server.rb --port=$PORT --signal-on-hup=TERM --dir=$APP_ROOT \
  --status-file=$APP_ROOT/tmp/pids/start_server.stat --pid-file=$APP_ROOT/tmp/pids/start_server.pid \
  --kill-old-delay=5 -- \
  bundle exec --keep-file-descriptors start_puma.rb puma -C config/puma.rb config.ru
