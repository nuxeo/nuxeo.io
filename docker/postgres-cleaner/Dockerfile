# PostgreSQL Cleaner
#
# VERSION               0.0.1

FROM       ubuntu:trusty
MAINTAINER Nuxeo <contact@nuxeo.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Update all packages
RUN apt-get update

# Upgrade Ubuntu
RUN apt-get upgrade -y

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y python-software-properties wget sudo net-tools

# Install PostgreSQL
RUN apt-get install -y postgresql-client-9.3

# Add script
ADD start.sh /root/start.sh

# Start PostgreSQL
ENTRYPOINT ["/bin/bash", "-c", "/root/start.sh"]
