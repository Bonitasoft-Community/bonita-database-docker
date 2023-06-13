FROM mcr.microsoft.com/mssql/server:2022-CU4-ubuntu-20.04

# OCI annotations to image
LABEL org.opencontainers.image.authors="Bonita R&D Engine Team <rd.engine@bonitasoft.com>" \
      org.opencontainers.image.title="Bonita SQL Server Database" \
      org.opencontainers.image.description="Pre-configured Microsoft SQL Server database image to work with Bonita" \
      org.opencontainers.image.documentation="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.source="https://github.com/Bonitasoft-Community/bonita-database-docker" \
      org.opencontainers.image.vendor="Bonitasoft" \
      org.opencontainers.image.url="https://www.bonitasoft.com/" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.version="2022-CU4"

ENV ACCEPT_EULA Y
ENV MSSQL_SA_PASSWORD DeLorean1985
ENV MSSQL_RPC_PORT 135
ENV MSSQL_DTC_TCP_PORT 51000
ENV MSSQL_PID Express

# change active user to root
USER root

# create the app directory
RUN mkdir -p /usr/src/app

# Bundle app source
COPY . /usr/src/app

# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/src/app/init-db.sh

# Grant permissions for the healthcheck script to be executable
RUN chmod +x /usr/src/app/healthcheck.sh

# set mssql as owner of the app directory
RUN chown -R mssql /usr/src/app

# change back to user mssql
USER mssql

WORKDIR /usr/src/app

CMD /bin/bash ./entrypoint.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/src/app/healthcheck.sh"]