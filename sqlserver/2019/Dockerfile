FROM mcr.microsoft.com/mssql/server:2019-CU8-ubuntu-16.04

LABEL maintainer="Bonita R&D Runtime team <rd.runtime@bonitasoft.com>"
LABEL vendor="bonitasoft"

ENV ACCEPT_EULA Y
ENV MSSQL_SA_PASSWORD DeLorean1985
ENV MSSQL_RPC_PORT 135
ENV MSSQL_DTC_TCP_PORT 51000
ENV MSSQL_PID Express

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


# Bundle app source
COPY . /usr/src/app

# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/src/app/init-db.sh

CMD /bin/bash ./entrypoint.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/src/app/healthcheck.sh"]