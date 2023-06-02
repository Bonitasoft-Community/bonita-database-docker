FROM mysql:8.0.33

# OCI annotations to image
LABEL org.opencontainers.image.authors="Bonita R&D Runtime Team <rd.engine@bonitasoft.com>" \
      org.opencontainers.image.title="Bonita MySQL Database" \
      org.opencontainers.image.description="Pre-configured MySQL database image to work with Bonita" \
      org.opencontainers.image.documentation="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.source="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.vendor="Bonitasoft" \
      org.opencontainers.image.url="https://www.bonitasoft.com/" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.version="8.0.33"

ENV MYSQL_ROOT_PASSWORD=root

# allow to bind volume for database backup/restore
VOLUME /opt/bonita/sql

# set docker.cnf config
COPY docker.cnf /etc/mysql/conf.d
COPY init-databases.sql /docker-entrypoint-initdb.d
COPY --chmod=755 healthcheck.sh /opt/bonita/

HEALTHCHECK --interval=5s --retries=120 CMD ["/opt/bonita/healthcheck.sh"]
