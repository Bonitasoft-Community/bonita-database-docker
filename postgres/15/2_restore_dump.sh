#!/bin/bash
set -e
##
##  Restore dumps from volume /opt/bonita/dump
##  dumps should have name bonita.dump and business_data.dump
##  dump using: pg_dump -h localhost -p 5432 -Ubonita bonita> bonita.dump

if [ -f /var/lib/postgresql/restore.lastExecution ]; then
  echo "Restore already executed: skipping dump restoration."
else
  touch /var/lib/postgresql/restore.inProgress
  #  plain text dump
  if [ -f /opt/bonita/dump/bonita.dump ]; then
    psql -d bonita -U bonita </opt/bonita/dump/bonita.dump
    date >/var/lib/postgresql/restore.lastExecution
  fi
  if [ -f /opt/bonita/dump/business_data.dump ]; then
    psql -d business_data -U business_data </opt/bonita/dump/business_data.dump
    date >/var/lib/postgresql/restore.lastExecution
  fi
  # compressed backup done using
  # pg_dump with -l option to generate the list file
  if [ -f /opt/bonita/dump/bonita.list ]; then
    echo "Restore bonita"
    pg_restore -d bonita -U bonita -Fc -L /opt/bonita/dump/bonita.list /opt/bonita/dump/bonita.pgdump
    psql -d bonita -U bonita -c "VACUUM ANALYZE"
    date >/var/lib/postgresql/restore.lastExecution
  fi
  if [ -f /opt/bonita/dump/business_data.list ]; then
    echo "Restore business_data"
    pg_restore -d business_data -U business_data -Fc -L /opt/bonita/dump/business_data.list /opt/bonita/dump/business_data.pgdump
    psql -d business_data -U business_data -c "VACUUM ANALYZE"
    date >/var/lib/postgresql/restore.lastExecution
  fi
  rm -vf /var/lib/postgresql/restore.inProgress
fi
