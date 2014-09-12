# PostgreSQL Cleaner
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Install PostgreSQL
RUN apt-get install -y postgresql-client-9.3

# Add script
ADD start.sh /root/start.sh

# Start PostgreSQL
ENTRYPOINT ["/bin/bash", "-c", "/root/start.sh"]
