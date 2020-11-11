# This image is based on mssql-server-linux image

First MS SQL Server Linux image supporting Distributing transactions.

See https://techcommunity.microsoft.com/t5/SQL-Server/Introducing-Distributed-transaction-functionality-on-SQL-Server/ba-p/786632

## additions

### configuration

Default value for `MSSQL_PID` environment variable is `Express`, but you can change it by setting
`-e 'MSSQL_PID=Enterprise'`, for instance, when creating a container.

See more configuration on [Microsoft Official base image](https://hub.docker.com/_/microsoft-mssql-server)

### databases

This image already contains the 2 databases:
* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)

## build it

    docker build -t bonitasoft/bonita-sqlserver:2017-CU22 .

## deploy to a registry

    docker push bonitasoft/bonita-sqlserver:2017-CU22

## run it

The simple way:

    docker run -d --name bonita-sqlserver-2017 -p :1433 bonitasoft/bonita-sqlserver:2017-CU22

The more-complete way:

    docker run -d --name bonita-sqlserver-2017 -e 'MSSQL_SA_PASSWORD=S0mES3cRet!P455W0rD' -e 'MSSQL_RPC_PORT=135' -e 'MSSQL_DTC_TCP_PORT=51000' \
        -p 51433:1433 -p 135:135 -p 51000:51000 bonitasoft/bonita-sqlserver:2017-CU22