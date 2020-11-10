# Pre-configured MySQL database image to work with Bonita 

This image is based on the [official MySQL image](https://hub.docker.com/_/mysql)

## additions 

### configuration

[/etc/mysql/conf.d/docker.cnf](docker.cnf) config file


### databases

* `bonita`:  owned by user `bonita` with password `bpm`  
* `business_data`: owned by user `business_data` with password `bpm`

## build it

```
# will use 'latest' as tag
docker build -t bonitasoft/bonita-mysql:8.0.22 .
```

## run it

default way

`docker run --name bonita-mysql-8.0 -p 3306:3306 -d bonitasoft/bonita-mysql:8.0.22`

using local volume for backup/restore

`docker run --name bonita-mysql-8.0 -p 3306:3306 -d -v"/myPath:/opt/bonita/sql" bonitasoft/bonita-mysql:8.0.22`


## shell

`docker exec -ti bonita-mysql-8.0 bash`

## push Docker image

`docker push bonitasoft/bonita-mysql:8.0.22`
