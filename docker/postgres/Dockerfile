# PostgreSQL Base image is a ubuntu precise image
#
# VERSION               0.0.1

FROM       ubuntu:precise
MAINTAINER Nuxeo <contact@nuxeo.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Update package manager
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

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
RUN sudo apt-get install -y supervisor postgresql-9.3 unzip vim openssh-server curl zip unzip

RUN mkdir -p /var/log/supervisor

# Copy scripts
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD postgres-waiter.py /root/postgres-waiter.py
ADD postgres-configure.sh /root/postgres-configure.sh
ADD postgres-setup.sh /root/postgres-setup.sh

RUN /bin/sh /root/postgres-setup.sh

# Expose default PostgreSQL and SSH ports
EXPOSE 5432 22

RUN mkdir -p /var/run/sshd
RUN echo 'root:nuxeoiocontainer' | chpasswd

# Start supervisord
CMD ["supervisord"]
