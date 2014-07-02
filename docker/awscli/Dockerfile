# AWS cli Executor image
#
# VERSION               0.0.1

FROM       ubuntu:trusty
MAINTAINER Nuxeo <contact@nuxeo.com>

# Update all packages
RUN apt-get update

# Upgrade Ubuntu
RUN apt-get upgrade -y

# Install dependencies
RUN apt-get install -y awscli
ADD write-awscli-conf.sh /bin/write-awscli-conf.sh
ADD awscli.sh /bin/awscli.sh

ENTRYPOINT ["awscli.sh"]
