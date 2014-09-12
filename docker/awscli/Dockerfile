# AWS cli Executor image
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Install dependencies
RUN apt-get install -y awscli
ADD write-awscli-conf.sh /bin/write-awscli-conf.sh
ADD awscli.sh /bin/awscli.sh

ENTRYPOINT ["awscli.sh"]
