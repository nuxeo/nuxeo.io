# Nuxeo IO Base image to run a nuxeo instance
#
# VERSION               0.0.1

FROM       quay.io/nuxeoio/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

# Install Nuxeo Dependencies
RUN perl -p -i -e "s/universe/universe multiverse/g" /etc/apt/sources.list


# Small trick to Install fuse(libreoffice dependency) because of container permission issue.
RUN apt-get -y install fuse || true
RUN rm -rf /var/lib/dpkg/info/fuse.postinst
RUN apt-get -y install fuse


# Create Nuxeo user
RUN useradd -m -d /home/nuxeo -p nuxeo nuxeo && adduser nuxeo sudo && chsh -s /bin/bash nuxeo
ENV NUXEO_USER nuxeo
ENV NUXEO_HOME /var/lib/nuxeo/server
ENV NUXEOCTL /var/lib/nuxeo/server/bin/nuxeoctl

RUN sudo apt-get install -y \
    openjdk-7-jdk \
    perl \
    locales \
    pwgen \
    imagemagick \
    ffmpeg2theora \
    ufraw \
    poppler-utils \
    libreoffice \
    libwpd-tools \
    gimp \
    ghostscript

RUN mkdir -p /var/run/sshd
RUN echo 'root:nuxeoiocontainer' | chpasswd

WORKDIR /tmp
ENV BUILD_YASM true

# Build ffmpeg
RUN git clone https://github.com/nuxeo/ffmpeg-nuxeo.git && \
    cd ffmpeg-nuxeo && \
    ./build-all.sh true && \
    cd .. && \
    rm -rf ffmpeg-nuxeo

# Expose default Tomcat and SSH ports
EXPOSE 8080 22
