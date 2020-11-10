# This image is based on MySQL 8.0 image

## additions 

### configuration

[/etc/mysql/conf.d/docker.cnf](docker.cnf) config file


### databases

* `bonita`:  owned by user `bonita` with password `bpm`  
* `business_data`: owned by user `business_data` with password `bpm`

## build it

```
# will use 'latest' as tag
docker build -t registry.rd.lan/bonitasoft/mysql-8.0.14:latest .`
```

## run it

default way

`docker run --name bonita-mysql-8.0.14 -p 3306:3306 -d registry.rd.lan/bonitasoft/mysql-8.0.14:latest`

using local volume for backup/restore

`docker run --name bonita-mysql-8.0.14 -p 3306:3306 -d -v"/myPath:/opt/bonita/sql" registry.rd.lan/bonitasoft/mysql-8.0.14:latest`


## shell

`docker exec -ti bonita-mysql-8.0 bash`

## push Docker image

`docker push registry.rd.lan/bonitasoft/mysql-8.0.14:latest`
