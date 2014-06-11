# Nuxeo IO Base image is a ubuntu precise image with all the dependencies needed by Nuxeo Platform
#
# VERSION               0.0.1

FROM       nuxeo/iobase
MAINTAINER Nuxeo <contact@nuxeo.com>

RUN apt-get -q -y install imagemagick ffmpeg2theora ufraw poppler-utils libreoffice libwpd-tools gimp ghostscript
WORKDIR /tmp
RUN git clone https://github.com/nuxeo/ffmpeg-nuxeo.git
ENV BUILD_YASM true
RUN cd ffmpeg-nuxeo && ./build-all.sh true

# Copy scripts
ADD nuxeo-install.sh /root/nuxeo-install.sh
ADD start.sh /root/start.sh

# Download & Install Nuxeo
RUN /bin/bash /root/nuxeo-install.sh

CMD ["/root/start.sh"]
