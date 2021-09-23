# Database docker images ready to use with Bonita

## supported DB vendors

* MySQL
    * [mysql 8.0](mysql/8.0/README.md)
* PostgreSQL
    * [postgres 9.6](postgres/9.6/README.md)
    * [postgres 11](postgres/11/README.md)
* Microsoft SQL Server (under the [MIT license](https://github.com/microsoft/mssql-docker/blob/master/LICENSE))
  * [sqlserver 2017](sqlserver/2017/README.md)
  * [sqlserver 2019](sqlserver/2019/README.md)
* Oracle
    * Not available publicly, as there is a redistribution License limitation

## Pre-configured databases

* bonita (user bonita/bpm)
* business_data (user business_data/bpm)

## Build images locally

See individual README in sub-folders.

## Publish images on Docker Hub

Requires to have the image built locally.

* Login onto Docker Hub with account `bonitadev` (see Keeper for account credentials):

      docker login -u bonitadev docker.io

* push the new image and its tagged name + latest tag (Example for Postgres latest image):

      docker push bonitasoft/bonita-postgres:12.6
      docker tag bonitasoft/bonita-postgres:12.6 bonitasoft/bonita-postgres:latest
      docker push bonitasoft/bonita-postgres:latest
* Ensure the images are pushed, accessing https://hub.docker.com/u/bonitasoft and checking tags are there.