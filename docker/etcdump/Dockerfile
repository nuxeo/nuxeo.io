# ectdump image
#
# VERSION               0.0.1

FROM       nuxeo/awscli
MAINTAINER Nuxeo <contact@nuxeo.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:chris-lea/node.js

# Update all packages
RUN apt-get update

# Upgrade Ubuntu
RUN apt-get upgrade -y

# Install dependencies
RUN apt-get install -y git nodejs
RUN npm install -g arkenio/etcdump
ADD etcdump.sh /bin/etcdump.sh
ADD config-arken.json /root/config-arken.json
ADD config-fleet.json /root/config-fleet.json

ENTRYPOINT ["etcdump.sh"]
