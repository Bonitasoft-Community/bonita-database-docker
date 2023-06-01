# Database docker images ready to use with Bonita

## Supported DB vendors

* MySQL
    * [mysql 8.0](mysql/8.0/README.md)
* PostgreSQL
    * [postgres 9.6](postgres/9.6/README.md)
    * [postgres 11](postgres/11/README.md)
    * [postgres 12](postgres/12/README.md)
    * [postgres 15](postgres/15/README.md)
* Microsoft SQL Server (under the [MIT license](https://github.com/microsoft/mssql-docker/blob/master/LICENSE))
    * [sqlserver 2017](sqlserver/2017/README.md)
    * [sqlserver 2019](sqlserver/2019/README.md)
* Oracle
    * Not available publicly, as there is a redistribution License limitation

## Pre-configured databases

* bonita (user bonita/bpm)
* business_data (user business_data/bpm)

## Build images locally

Run Docker command depending on the DB vendor and related version:

```shell
docker build -t bonitasoft/bonita-<vendor>:<version>
```

For instance with PostgreSQL: `docker build -t bonitasoft/bonita-postgres:13.5`

## Publish images on Docker Hub

Requires to have the image built locally.

* Login onto Docker Hub with account `bonitadev` (see Keeper for account credentials):

```shell
docker login -u bonitadev docker.io
```

* Push the image and its tagged name + latest tag:

```shell
docker push bonitasoft/bonita-<vendor>:<version>
docker tag bonitasoft/bonita-<vendor>:<version> bonitasoft/bonita-<vendor>:latest
docker push bonitasoft/bonita-<vendor>:latest
```

* Ensure the images are pushed, accessing https://hub.docker.com/u/bonitasoft and checking tags are there.
