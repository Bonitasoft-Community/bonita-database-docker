FROM postgres:9.6.16-alpine

LABEL maintainer="Bonita R&D Runtime team: anthony.birembaut@bonitasoft.com,\
emmanuel.duchastenier@bonitasoft.com,\
baptiste.mesta@bonitasoft.com,\
pascal.garcia@bonitasoft.com,\
bishal.thapaliya@bonitasoft.com,\
danila.mazour@bonitasoft.com,\
dumitru.corini@bonitasoft.com"
LABEL vendor="bonitasoft"

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# restore dump on startup if dumpfile is present
VOLUME /opt/bonita/dump

COPY 0_init-databases.sql /docker-entrypoint-initdb.d/0_init-databases.sql
COPY 1_set-max_prepared_transactions.sh /docker-entrypoint-initdb.d/1_set-max_prepared_transactions.sh
COPY 2_restore_dump.sh /docker-entrypoint-initdb.d/2_restore_dump.sh
COPY healthcheck.sh /usr/local/bin/healthcheck.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/local/bin/healthcheck.sh"]