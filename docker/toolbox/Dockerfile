# Nuxeo toolbox for Arken cluster
#
# VERSION               0.0.1

FROM       ubuntu:precise
MAINTAINER Nuxeo <contact@nuxeo.com>

## Update system
RUN apt-get update
RUN apt-get install -y wget ca-certificates build-essential tmux htop vim curl git

ADD tmux.conf /root/.tmux.conf

CMD tmux
