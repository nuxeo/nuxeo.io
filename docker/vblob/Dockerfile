# vBlob image is a ubuntu precise image
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
RUN apt-get install -y sudo net-tools

# Upgrade Ubuntu
RUN apt-get update
RUN apt-get upgrade -y

# Install node.js dependencies to build
RUN sudo apt-get install -y nodejs git

# Build vBlob module
RUN git clone https://github.com/cloudfoundry-attic/vblob
WORKDIR vblob
ADD config.json /vblob/config.json

EXPOSE 9981

# Start vBlob
CMD ["/usr/bin/node", "server.js"]
