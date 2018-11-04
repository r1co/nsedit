FROM php:7.2 

MAINTAINER r1co@post-box.cc

ENV DEBIAN_FRONTEND noninteractive

# install packages 
RUN apt-get -y update && \
    apt-get -y install curl git-core libcurl3-dev && rm -rf /var/lib/apt/lists/*

# install nsedit 
RUN mkdir /app
RUN git clone --recursive https://github.com/tuxis-ie/nsedit.git /app/nsedit
RUN cp /app/nsedit/includes/config.inc.php-dist /app/nsedit/includes/config.inc.php
RUN chmod +x /app/nsedit/docker-entrypoint.sh

# install php extenstions 
RUN docker-php-ext-install curl

# link php 
RUN ln -s /usr/local/bin/php /usr/bin/php

# Define working directory.
VOLUME /app/nsedit
WORKDIR /app/nsedit
EXPOSE 8080


CMD ["sh", "-c", "/app/nsedit/docker-entrypoint.sh"]
