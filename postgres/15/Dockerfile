FROM postgres:15.4-alpine

# OCI annotations to image
LABEL org.opencontainers.image.authors="Bonita R&D Engine Team" \
      org.opencontainers.image.title="Bonita Postgres Database" \
      org.opencontainers.image.description="Pre-configured Postgres database image to work with Bonita" \
      org.opencontainers.image.documentation="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.source="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.vendor="Bonitasoft" \
      org.opencontainers.image.url="https://www.bonitasoft.com/" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.version="15.4"

ENV POSTGRES_PASSWORD=change-me

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# restore dump on startup if dumpfile is present
VOLUME /opt/bonita/dump

COPY 0_init-databases.sql /docker-entrypoint-initdb.d/0_init-databases.sql
COPY 1_update-postgresql-conf.sh /docker-entrypoint-initdb.d/1_update-postgresql-conf.sh
COPY 2_restore_dump.sh /docker-entrypoint-initdb.d/2_restore_dump.sh
COPY healthcheck.sh /usr/local/bin/healthcheck.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/local/bin/healthcheck.sh"]
