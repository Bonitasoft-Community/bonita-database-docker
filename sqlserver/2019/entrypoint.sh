#!/bin/bash

# start SQL Server and start the script to create the DB. Wait for all background process to finish, otherwise the docker container
# stops when init-db finishes:
/opt/mssql/bin/sqlservr & /usr/src/app/init-db.sh & wait