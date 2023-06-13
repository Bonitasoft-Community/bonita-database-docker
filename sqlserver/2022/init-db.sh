#!/bin/bash

args=(
  -U sa
  -P "${MSSQL_SA_PASSWORD}"
  -d master
  -Q 'set nocount on; select 1'
  -h -1
  -W
)
checkLogin="?"
maxTries=30
currentTries=0
# temporary disable strict command return code checking
echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] waiting for sa connection to be UP "
set +e
while [ $currentTries -lt $maxTries ] && [ "$checkLogin" != "1" ]; do
  ((currentTries++))
  echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] checking sa connection (${currentTries} / ${maxTries}) "
  checkLogin=$(/opt/mssql-tools/bin/sqlcmd "${args[@]}")
  echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] check login result: (${currentTries} / ${maxTries}) *${checkLogin}*"
  sleep 2
done
echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] check login result: (${currentTries} / ${maxTries}) *${checkLogin}*"
echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] sa connection is UP"

# restore strict non 0 exit code
set -e
echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] creating database"
/opt/mssql-tools/bin/sqlcmd -U sa -P "${MSSQL_SA_PASSWORD}" -d master -i 0_init-databases.sql
echo "$(date "+%Y-%m-%d %H:%M:%S.%2N") [init-db] database created"
