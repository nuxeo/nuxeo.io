# nuxeo. Manager Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       nuxeo/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q -y upgrade

# Copy scripts
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD start.sh /root/start.sh
ADD fleetctl /usr/bin/fleetctl

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh

CMD ["/root/start.sh"]
