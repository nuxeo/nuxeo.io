# S3 cleaner Base image is a ubuntu precise image
#
# VERSION               0.0.1

FROM       ubuntu:trusty
MAINTAINER Nuxeo <contact@nuxeo.com>

# Update all packages
RUN apt-get update

# Upgrade Ubuntu
RUN apt-get upgrade -y

# Install dependencies
RUN apt-get install -y wget sudo libdigest-hmac-perl curl unzip

# Get third party library
RUN wget --no-verbose http://s3.amazonaws.com/doc/s3-example-code/s3-curl.zip
RUN unzip s3-curl.zip -d /tmp
RUN cp /tmp/s3-curl/s3curl.pl /usr/bin/s3curl.pl
RUN chmod +x /usr/bin/s3curl.pl

# Add script
ADD start.sh /root/start.sh

# Add settings
ADD s3curl /usr/bin/.s3curl

# Start S3 Cleaner
ENTRYPOINT ["/bin/bash", "-c", "/root/start.sh"]
