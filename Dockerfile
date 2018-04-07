FROM caddy
LABEL maintainer="contact-docker@mo-mar.de"

USER 0

RUN apk add --no-cache php7 php7-fpm \
    ca-certificates \
    php7-gd php7-mysqli php7-sqlite3 \
    php7-session php7-ctype \
    php7-xml \
    php7-zip \
    php7-xmlreader \
    php7-zlib \
    php7-opcache \
    php7-mcrypt \
    php7-openssl \
    php7-curl \
    php7-json \
    php7-dom \
    php7-phar \
    php7-mbstring \
    php7-pdo \
    php7-pdo_sqlite \
    php7-pdo_mysql \
    php7-simplexml \
    php7-tokenizer \
    php7-xmlwriter &&\
    mkdir /run/php && chmod 777 /run/php

ADD Caddyfile /data/Caddyfile
ADD php-fpm.conf /etc/php7/php-fpm.conf
ADD php.conf /etc/php7/php-fpm.d/www.conf
ADD php.ini /etc/php7/php.ini

USER 1000

CMD ["/smell-baron", "/usr/sbin/php-fpm7", "--allow-to-run-as-root", "--nodaemonize", "--fpm-config", "/etc/php7/php-fpm.conf", \
              "---", "/usr/local/bin/caddy", "-agree=true", "-conf=/data/Caddyfile", "-root=/data", "-log=stdout", "-email=", "-grace=1s"]
