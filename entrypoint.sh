#!/bin/bash
set -e

FILE=/app/tmp/pids/server.pid
if test -f "$FILE"; then
  rm -f $FILE
fi

exec "$@"
