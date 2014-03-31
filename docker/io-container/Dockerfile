# Nuxeo IO Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       ubuntu:precise
MAINTAINER Nuxeo <contact@nuxeo.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Update package manager
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update all packages
RUN apt-get update

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y python-software-properties wget sudo net-tools

# Add postgresql Repository for 9.3
RUN apt-add-repository "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
RUN wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Upgrade Ubuntu
RUN apt-get update
RUN apt-get upgrade -y

# Small trick to Install fuse(libreoffice dependency) because of container permission issue.
RUN apt-get -y install fuse || true
RUN rm -rf /var/lib/dpkg/info/fuse.postinst
RUN apt-get -y install fuse

# Install Nuxeo Dependencies
# RUN sudo apt-get install -y acpid openjdk-7-jdk libreoffice imagemagick poppler-utils ffmpeg ffmpeg2theora ufraw libwpd-tools perl locales pwgen dialog supervisor unzip vim
RUN sudo apt-get install -y openjdk-7-jdk perl locales pwgen supervisor postgresql-9.3 unzip vim openssh-server curl zip unzip

RUN mkdir -p /var/log/supervisor

# Create Nuxeo user
RUN useradd -m -d /home/nuxeo -p nuxeo nuxeo && adduser nuxeo sudo && chsh -s /bin/bash nuxeo
ENV NUXEO_USER nuxeo
ENV NUXEO_HOME /var/lib/nuxeo/server

# Copy scripts
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD entrypoint.sh /root/entrypoint.sh
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD nuxeo-boot.sh /root/nuxeo-boot.sh
ADD postgres-waiter.py /root/postgres-waiter.py
ADD postgres-configure.sh /root/postgres-configure.sh

ADD etcdctl /usr/bin/etcdctl

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh
ENV NUXEOCTL /var/lib/nuxeo/server/bin/nuxeoctl

# Expose default Tomcat and SSH ports
EXPOSE 8080 22

RUN mkdir -p /var/run/sshd
RUN echo 'root:nuxeoiocontainer' | chpasswd

# Start supervisord
ENTRYPOINT ["sh", "/root/entrypoint.sh"]
CMD ["supervisord"]
