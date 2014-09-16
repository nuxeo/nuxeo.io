# nuxeo. Manager Base image is a ubuntu trusty image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/nuxeo-base
MAINTAINER Nuxeo <contact@nuxeo.com>

# Copy scripts
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD start.sh /root/start.sh

### Build fleetctl until we use the REST API
RUN apt-get install -y ca-certificates build-essential

### For some reason `go get` required these to run, despite it not being documented?
RUN apt-get install -y mercurial

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /usr/local/go/

RUN wget --no-verbose https://go.googlecode.com/files/go1.2.1.src.tar.gz
RUN tar -v -C /usr/local -xzf go1.2.1.src.tar.gz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

WORKDIR /tmp
RUN git clone https://github.com/coreos/fleet.git
RUN cd fleet && git checkout v0.6.2 && ./build && cp ./bin/fleetctl /usr/bin && cd .. && rm -rf /tmp/fleet
### End of fleetctl build


# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh

CMD ["/root/start.sh"]
