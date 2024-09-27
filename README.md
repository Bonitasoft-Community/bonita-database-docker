# Database docker images ready to use with Bonita

## Supported DB vendors

* MySQL
    * [MySQL 8.0](mysql/8.0/README.md)
* PostgreSQL
    * [Postgres 9.6](postgres/9.6/README.md)
    * [Postgres 11](postgres/11/README.md)
    * [Postgres 12](postgres/12/README.md)
    * [Postgres 15](postgres/15/README.md)
* Microsoft SQL Server (under the [MIT license](https://github.com/microsoft/mssql-docker/blob/master/LICENSE))
    * [SQL Server 2017](sqlserver/2017/README.md)
    * [SQL Server 2019](sqlserver/2019/README.md)
    * [SQL Server 2022](sqlserver/2022/README.md)
* Oracle
    * Not available publicly, as there is a redistribution License limitation

## Pre-configured databases

* bonita (user bonita/bpm)
* business_data (user business_data/bpm)

## Build images locally

Run Docker command depending on the DB vendor and related version:

```shell
docker build -t bonitasoft/bonita-<vendor>:<version> .
```

For instance with PostgreSQL: `docker build -t bonitasoft/bonita-postgres:16.4 .`

## Publish images on Docker Hub

Use the publication Github action:

* Select the database vendor
* Set the vendor version folder
* Set an image version
* Set if this version should be tagged as latest 
