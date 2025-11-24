#!/bin/bash
set -eo pipefail

# -C is to force "TrustServerCertificate"
args=(
  -U bonita
  -P bpm
  -d bonita
  -Q "set nocount on; select count(*) from sys.objects"
  -h -1
  -W
  -k
  -C
)

if select="$(/opt/mssql-tools18/bin/sqlcmd "${args[@]}")" && [ "$select" -gt 1 ]; then
  exit 0
fi
exit 1
