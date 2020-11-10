FROM mysql:8.0.22

LABEL maintainer="Bonita R&D Runtime team <rd.runtime@bonitasoft.com>"
LABEL vendor="bonitasoft"

ENV MYSQL_ROOT_PASSWORD=root

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# set docker.cnf config
COPY docker.cnf /etc/mysql/conf.d
COPY init-databases.sql /docker-entrypoint-initdb.d
COPY healthcheck.sh /opt/bonita/

HEALTHCHECK --interval=5s --retries=120 CMD ["/opt/bonita/healthcheck.sh"]
