# Nuxeo IO Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       nuxeo/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Copy scripts
ADD nuxeo-install.sh /root/nuxeo-install.sh

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh
