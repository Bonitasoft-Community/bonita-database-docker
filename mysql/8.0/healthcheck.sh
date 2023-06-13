#!/bin/bash
# source: https://github.com/docker-library/healthcheck
set -eo pipefail

host="$(hostname --ip-address || echo '127.0.0.1')"
user="bonita"
export MYSQL_PWD="bpm"

args=(
  # force mysql to not use the local "mysqld.sock" (test "external" connectivity)
  -h"$host"
  -u"$user"
  --silent
)

if command -v mysqladmin &>/dev/null; then
  if mysqladmin "${args[@]}" ping >/dev/null; then
    exit 0
  fi
else
  if select="$(echo 'SELECT 1' | mysql "${args[@]}")" && [ "$select" = '1' ]; then
    exit 0
  fi
fi

exit 1
