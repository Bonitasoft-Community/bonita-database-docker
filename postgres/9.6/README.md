# Pre-configured Postgres database image to work with Bonita 

This image is based on the [official Postgres image](https://hub.docker.com/_/postgres)

## Additions

### Configuration

set required `max_prepared_transactions` setting required by Bonita


### Databases

When starting a new container, it will create two databases...
* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)


## Build it

    Note: tag is just an argument and is not provided by Dockerfile. so 

`docker build -t bonitasoft/bonita-postgres:9.6 .`

## Restore dump

It will restore dumps present in the volume /opt/bonita/dump

For plain text sql form, dumps must be named `bonita.dump` and `business_data.dump`

Create those dump using:

```
pg_dump -h localhost -p 5432 -Ubonita bonita> /opt/bonita/dump/bonita.dump
pg_dump -h localhost -p 5432 -Ubusiness_data business_data> /opt/bonita/dump/business_data.dump
```

for compressed format, dumps must be named `bonita.pgdump` and `business_data.pgdump`. This format is used
with a .list file that allow to white list items to restore:


```
# --quote-all-identifiers : ensure no issues with bonita columns name that use a PostgreSQL reserved word
# --encoding=utf8 : required
# -F c : use PostgreSQL compress format
pg_dump -h localhost -p 5432 -U bonita --quote-all-identifiers --encoding=utf8 -F c bonita > /opt/bonita/dump/bonita.pgdump

# prepare white-list file for pg_restore
# this will read backup file and generat a TOC (Table Of Content) stored in a white list file
# then edit this file to comment with a `;` items you don't want to restore 
pg_restore -l /opt/bonita/dump/bonita.pgdump > /opt/bonita/dump/bonita.list 

# same for BDM
pg_dump -h localhost -p 5432 -U business_data --quote-all-identifiers --encoding=utf8 -F c business_data > /opt/bonita/dump/business_data.pgdump
pg_restore -l /opt/bonita/dump/business_data.pgdump > /opt/bonita/dump/business_data.list 
```

then run the docker using volume `-v <path to dumps>:/opt/bonita/dump`

    Note: if container already exists, it must be removed, using `docker rm <CONTAINER_ID>`, unless restore won't be applied


### Restore dump from file not using default 'bonita' schema
* create a container with:
  * extra parameter `-e POSTGRES_PASSWORD=mysecretpassword`, in order to be able to access the tables with a known user (`postgres`) and password
  * extra volume mapping parameter with the dump file, to access it easily from within the container  
  Eg. `docker run --name postgres-from-dump -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d -v /home/manu/work:/opt/bonita/dump bonitasoft/bonita-postgres:9.6
* access the new container through `docker exec -ti <container_id>`
* run `psql -U postgres bonita < ./my_dump_file.sql`

## Run it

default way

`docker run -p 5432:5432 -d bonitasoft/bonita-postgres:9.6`

recommended way, to have datafiles out of container: bind a volume to **/var/lib/postgresql/data**

`docker run -p 5432:5432 -d -v "/PATH_TO_DATA_FILES:/var/lib/postgresql/data" bonitasoft/bonita-postgres:9.6`


with local volume for backup/restore and script exchange

`docker run -p 5432:5432 -d -v "/PATH_TO_DATA_FILES:/var/lib/postgresql/data" -v"/MY_SQL_FOLDER:/opt/bonita/sql" bonitasoft/bonita-postgres:9.6` 


## Execute shell command inside container

`docker exec -ti <CONTAINER_ID> bash`

Example to display Bonita version number:

`docker exec -it <CONTAINER_ID> psql -U bonita -c 'select version from platform' | grep "7\."`


## Test it

use provided docker-compose example
```
docker-compose up --build -d
# do some tests 
docker-compose down -v --remove-orphans

```