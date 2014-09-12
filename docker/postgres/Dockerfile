# PostgreSQL Base image is a ubuntu precise image
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Install PostgreSQL
RUN apt-get install -y postgresql-9.3

# Copy scripts
ADD start.sh /root/start.sh
ADD pg_hba.conf /root/pg_hba.conf

# Expose default PostgreSQL and SSH ports
EXPOSE 5432

# Shared Volumes
# VOLUME	["/opt/db:/opt/db:rw"]

# Start PostgreSQL
CMD ["/root/start.sh"]
