#!/bin/bash
set -eo pipefail

args=(
  -U bonita
  -P bpm
  -d bonita
  -Q "set nocount on; select count(*) from sys.objects"
  -h -1
  -W
  -k
)

if select="$(/opt/mssql-tools/bin/sqlcmd "${args[@]}")" && [ "$select" -gt 1 ]; then
  exit 0
fi
exit 1
