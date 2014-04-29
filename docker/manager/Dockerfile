# nuxeo. Manager Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       nuxeo/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Copy scripts
ADD fleet-install.sh /root/fleet-install.sh
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD start.sh /root/start.sh

# Download & Install fleetctl
RUN /bin/bash /root/fleet-install.sh

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh
