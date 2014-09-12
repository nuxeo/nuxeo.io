# Nuxeo IO Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       ubuntu:trusty
MAINTAINER Nuxeo <contact@nuxeo.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# First install apt needed utility package
RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common wget

# Add postgresql Repository for 9.3
RUN apt-add-repository "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
RUN wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# First install of common packages
RUN apt-get install -y \
    sudo \
    net-tools \
    git \
    postgresql-client-9.3 \
    vim \
    curl \
    zip \
    unzip


# Update/Upgrad all packages on each build
ONBUILD RUN apt-get update && apt-get upgrade -y