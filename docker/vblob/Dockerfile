# vBlob image is a ubuntu precise image
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Install node.js dependencies to build
RUN sudo apt-get install -y nodejs

# Build vBlob module
RUN git clone https://github.com/cloudfoundry-attic/vblob
WORKDIR vblob
ADD config.json /vblob/config.json

EXPOSE 9981

# Start vBlob
CMD ["/usr/bin/node", "server.js"]
