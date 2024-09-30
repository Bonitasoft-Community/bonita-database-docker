#!/bin/bash
# inspired by https://github.com/docker-library/healthcheck
set -eo pipefail

# check if restore is in progress (see 2_restore_dump.sh)
if [ -f /var/lib/postgresql/restore.inProgress ]; then
  echo "Database restore in progress. Not yet healthy."
  exit 1
fi

host="$(hostname -i || echo '127.0.0.1')"
user="bonita"
db="bonita"
export PGPASSWORD="bpm"

args=(
  # force postgres to not use the local unix socket (test "external" connectivity)
  --host "$host"
  --username "$user"
  --dbname "$db"
  --quiet --no-align --tuples-only
)

if select="$(echo 'SELECT 1' | psql "${args[@]}")" && [ "$select" = '1' ]; then
  # host is healthy
  exit 0
fi

# host is not healthy
exit 1
