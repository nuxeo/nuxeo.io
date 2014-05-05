# PostgreSQL Base image is a ubuntu precise image
#
# VERSION               0.0.1

FROM       ubuntu:precise
MAINTAINER Nuxeo <contact@nuxeo.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Update all packages
RUN apt-get update

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y python-software-properties wget sudo net-tools

# Add PostgreSQL Repository for 9.3
RUN apt-add-repository "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
RUN wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Upgrade Ubuntu
RUN apt-get update
RUN apt-get upgrade -y

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
