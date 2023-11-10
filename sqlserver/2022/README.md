# Pre-configured Microsoft SQL Server database image to work with Bonita

This image is based on the [official Microsoft SQL Server image](https://hub.docker.com/_/microsoft-mssql-server).

## Additions

### Configuration

Default value for `MSSQL_PID` environment variable is `Express`, but you can change it by
setting `-e 'MSSQL_PID=Enterprise'`, for instance, when creating a container.

See more configuration on [Microsoft Official base image](https://hub.docker.com/_/microsoft-mssql-server).

Check the list of available tags [on Microsoft site](https://mcr.microsoft.com/v2/mssql/server/tags/list)
to update to the latest version.

### Databases

This image is configured with the two databases required by Bonita:

* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)

## How to use this image

The simple way:

```shell
docker run -d --name bonita-sqlserver -p 1433:1433 bonitasoft/bonita-sqlserver:2022-CU4
```

The more-complete way:

```shell
docker run -d \
      --name bonita-sqlserver \
      -e 'MSSQL_SA_PASSWORD=Change-Me-123' \
      -e 'MSSQL_RPC_PORT=135' \
      -e 'MSSQL_DTC_TCP_PORT=51000' \
      -p 1433:1433 \
      -p 135:135 \
      -p 51000:51000 \
      bonitasoft/bonita-sqlserver:2022-CU4
```

## Container shell access

```shell
docker exec -it bonita-sqlserver bash
```

## Viewing SQL Server logs

```shell
docker logs bonita-sqlserver
```

## How to use this image with Bonita

Please refer to [Bonitasoft official documentation](https://documentation.bonitasoft.com/bonita/latest/runtime/bonita-docker-installation)
for examples on how to run this image using a Bonita Docker image.
