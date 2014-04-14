# Nuxeo go environment Base image based on a ubuntu precise image with all the dependencies needed
#
# VERSION               0.0.1

FROM       ubuntu:precise
MAINTAINER Nuxeo <contact@nuxeo.com>

## Update system
RUN apt-get update
RUN apt-get install -y wget ca-certificates build-essential

### For some reason `go get` required these to run, despite it not being documented?
RUN apt-get install -y git mercurial

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /usr/local/go/

RUN wget --no-verbose https://go.googlecode.com/files/go1.2.src.tar.gz
RUN tar -v -C /usr/local -xzf go1.2.src.tar.gz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

RUN go get github.com/nuxeo/etcd-netfw
WORKDIR /usr/local/go/src/github.com/nuxeo/etcd-netfw
RUN go build

# Expose default listening amb port
EXPOSE 1337

ADD service-amb.sh /usr/bin/service-amb.sh
ENTRYPOINT ["/usr/bin/service-amb.sh"]
