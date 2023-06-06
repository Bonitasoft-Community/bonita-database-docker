FROM postgres:15.3-alpine

# OCI annotations to image
LABEL org.opencontainers.image.authors="Bonita R&D Engine Team <rd.engine@bonitasoft.com>" \
      org.opencontainers.image.title="Bonita Postgres Database" \
      org.opencontainers.image.description="Pre-configured Postgres database image to work with Bonita" \
      org.opencontainers.image.documentation="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.source="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.vendor="Bonitasoft" \
      org.opencontainers.image.url="https://www.bonitasoft.com/" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.version="15.3"

ENV POSTGRES_PASSWORD=DEFAULT_BONITA_ROOT_PSSWD

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# restore dump on startup if dumpfile is present
VOLUME /opt/bonita/dump

COPY 0_init-databases.sql /docker-entrypoint-initdb.d/0_init-databases.sql
COPY 1_set-max_prepared_transactions.sh /docker-entrypoint-initdb.d/1_set-max_prepared_transactions.sh
COPY 2_restore_dump.sh /docker-entrypoint-initdb.d/2_restore_dump.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["pg_isready", "-U", "postgres"]
