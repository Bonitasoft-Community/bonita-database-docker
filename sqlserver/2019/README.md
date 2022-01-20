# This image is based on mssql-server-linux image

## additions

### configuration

Default value for `MSSQL_PID` environment variable is `Express`, but you can change it by setting
`-e 'MSSQL_PID=Enterprise'`, for instance, when creating a container.

See more configuration on [Microsoft Official base image](https://hub.docker.com/_/microsoft-mssql-server)

Check the list of available tags [on Microsoft site](https://mcr.microsoft.com/v2/mssql/server/tags/list)
to update to the latest version.

### databases

This image already contains the 2 databases:
* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)

## build it

    docker build -t bonitasoft/bonita-sqlserver:2019-CU8 .

## deploy to a registry

    docker push bonitasoft/bonita-sqlserver:2019-CU8

## run it

The simple way:

    docker run -d --name bonita-sqlserver-2019 -p :1433 bonitasoft/bonita-sqlserver:2019-CU8

The more-complete way:

    docker run -d --name bonita-sqlserver-2019 -e 'MSSQL_SA_PASSWORD=S0mES3cRet!P455W0rD' -e 'MSSQL_RPC_PORT=135' -e 'MSSQL_DTC_TCP_PORT=51000' \
        -p 51433:1433 -p 135:135 -p 51000:51000 bonitasoft/bonita-sqlserver:2019-CU8