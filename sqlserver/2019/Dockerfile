FROM mcr.microsoft.com/mssql/server:2019-CU14-ubuntu-20.04

LABEL maintainer="Bonita R&D Runtime team: anthony.birembaut@bonitasoft.com,\
emmanuel.duchastenier@bonitasoft.com,\
baptiste.mesta@bonitasoft.com,\
pascal.garcia@bonitasoft.com,\
bishal.thapaliya@bonitasoft.com,\
danila.mazour@bonitasoft.com,\
dumitru.corini@bonitasoft.com"
LABEL vendor="bonitasoft"

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

# set mssql as owner of the app directory
RUN chown -R mssql /usr/src/app

# change back to user mssql
USER mssql

WORKDIR /usr/src/app

CMD /bin/bash ./entrypoint.sh

HEALTHCHECK --interval=5s --retries=120 CMD ["/usr/src/app/healthcheck.sh"]