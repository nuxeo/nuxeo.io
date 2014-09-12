# nuxeo. Manager Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       nuxeo/nuxeo-base
MAINTAINER Nuxeo <contact@nuxeo.com>

# Copy scripts
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD start.sh /root/start.sh

ADD fleetctl /usr/bin/fleetctl

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh

CMD ["/root/start.sh"]
