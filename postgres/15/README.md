# Pre-configured Postgres database image to work with Bonita

This image is based on the [official Postgres image](https://hub.docker.com/_/postgres).

## Additions

### Configuration

The property `max_prepared_transactions` is required by Bonita and is set to `100`.

### Databases

This image is configured with the two databases required by Bonita:

* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)

## How to use this image

- Default way:

```shell
docker run -d --name bonita-postgres -p 5432:5432 bonitasoft/bonita-postgres:15.3
```

- Recommended way, to have datafiles out of container by binding a volume to **/var/lib/postgresql/data**:

```shell
docker run -d \
      --name bonita-postgres \
      -p 5432:5432 \
      -v /my/postgres/datadir:/var/lib/postgresql/data \
      bonitasoft/bonita-postgres:15.3
```

- With local volume for backup/restore and script exchange:

```shell
docker run -d \
      --name bonita-postgres \
      -p 5432:5432 \
      -v /my/postgres/datadir:/var/lib/postgresql/data \
      -v /my/sql/folder:/opt/bonita/sql \
      bonitasoft/bonita-postgres:15.3
```

## Container shell access

```shell
docker exec -it bonita-postgres bash
```

## Viewing Postgres logs

```shell
docker logs bonita-postgres
```

## How to restore dump

It will restore dumps present in the volume `/opt/bonita/dump`

For plain text sql form, dumps must be named `bonita.dump` and `business_data.dump`

Create those dump using:

```shell
pg_dump -h localhost -p 5432 -Ubonita bonita > /opt/bonita/dump/bonita.dump
pg_dump -h localhost -p 5432 -Ubusiness_data business_data > /opt/bonita/dump/business_data.dump
```

For compressed format, dumps must be named `bonita.pgdump` and `business_data.pgdump`. This format is used with a .list
file that allow to whitelist items to restore:

```shell
# --quote-all-identifiers : ensure no issues with bonita columns name that use a PostgreSQL reserved word
# --encoding=utf8 : required
# -F c : use PostgreSQL compress format
pg_dump -h localhost -p 5432 -U bonita --quote-all-identifiers --encoding=utf8 -F c bonita > /opt/bonita/dump/bonita.pgdump

# prepare white-list file for pg_restore
# this will read backup file and generate a TOC (Table Of Content) stored in a white list file
# then edit this file to comment with a `;` items you don't want to restore 
pg_restore -l /opt/bonita/dump/bonita.pgdump > /opt/bonita/dump/bonita.list 

# same for BDM
pg_dump -h localhost -p 5432 -U business_data --quote-all-identifiers --encoding=utf8 -F c business_data > /opt/bonita/dump/business_data.pgdump
pg_restore -l /opt/bonita/dump/business_data.pgdump > /opt/bonita/dump/business_data.list 
```

Then run the docker using volume `-v /my/postgres/dump:/opt/bonita/dump`

    Note: if container already exists, it must be removed, using `docker rm <CONTAINER_ID>`, unless restore will not be applied

### Restore dump from file not using default 'bonita' schema

* Create a container with:
    * Extra parameter `-e POSTGRES_PASSWORD=mysecretpassword`, in order to be able to access the tables with a known
      user (`postgres`) and password
    * Extra volume mapping parameter with the dump file, to access it easily from within the container. For example:
      ```shell
      docker run -d --name postgres-from-dump -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -v /my/postgres/dump:/opt/bonita/dump bonitasoft/bonita-postgres:15.3
      ```
* Access the new container through `docker exec -it postgres-from-dump`
* Run `psql -U postgres bonita < ./my_dump_file.sql`

## How to use this image with Bonita

Please refer to [Bonitasoft official documentation](https://documentation.bonitasoft.com/bonita/latest/runtime/bonita-docker-installation)
for examples on how to run this image using a Bonita Docker image.
