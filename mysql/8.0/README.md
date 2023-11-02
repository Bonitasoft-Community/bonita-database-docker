# Pre-configured MySQL database image to work with Bonita

This image is based on the [official MySQL image](https://hub.docker.com/_/mysql).

## Additions

### Configuration

See [docker.cnf](https://github.com/Bonitasoft-Community/bonita-database-docker/blob/main/mysql/8.0/docker.cnf) config
file (located in `/etc/mysql/conf.d/` directory within the image itself).

### Databases

This image is configured with the two databases required by Bonita:

* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)

## How to use the image

- Default way:

```shell
docker run -d --name bonita-mysql -p 3306:3306 bonitasoft/bonita-mysql:8.0.33
```

- Using local volume for backup/restore:

```shell
docker run -d \
      --name bonita-mysql \
      -p 3306:3306 \
      -v /my/sql/folder:/opt/bonita/sql \
      bonitasoft/bonita-mysql:8.0.33
```

## Container shell access

```shell
docker exec -it bonita-mysql bash
```

## Viewing MySQL logs

```shell
docker logs bonita-mysql
```

## How to test this image

See `docker-compose.yml` files under [test](test) folder with examples on how to test this image using a Bonita Docker image.

To execute it:

```shell
docker compose up --build -d
```

To shut it down and clear your environment:

```shell
docker compose down -v --remove-orphans
```
