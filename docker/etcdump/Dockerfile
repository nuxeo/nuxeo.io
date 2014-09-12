# ectdump image
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/awscli
MAINTAINER Nuxeo <contact@nuxeo.com>

RUN apt-add-repository ppa:chris-lea/node.js

# Install dependencies
RUN apt-get install -y nodejs npm
RUN npm install -g git://github.com/arkenio/etcdump.git#v0.1.0
ADD etcdump.sh /bin/etcdump.sh
ADD config-arken.json /root/config-arken.json
ADD config-fleet.json /root/config-fleet.json

ENTRYPOINT ["etcdump.sh"]
