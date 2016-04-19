#docker build -t oleksiichernomaz/php-fpm:7.0 .
#docker run -it oleksiichernomaz/php-fpm:7.0 bash
FROM php:7.0-fpm
MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
LABEL version="2.1.1"

ENV XDEBUG_VERSION 2.4.0
ENV XCACHE_VERSION 3.2.0
ENV GEOIP_VERSION 1.1.0

# Install modules
RUN apt-get update && apt-get install -y --force-yes \
        vim wget git npm\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libpq-dev \
        libphp-predis
# Install additional core extensions
RUN docker-php-ext-install \
        mbstring \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip \
        opcache \
        mcrypt
# Install GD
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd

# install redis
RUN cd /usr/src/php/ext \
    && git clone https://github.com/phpredis/phpredis.git redis \
    && cd redis \
    && git checkout php7 \
    && phpize \
    && ./configure --enable-redis \
    && cd .. \
    && docker-php-ext-install redis

#install phpunit
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

#install minifier
RUN npm install -g uglify-js \
    && npm install -g uglifycss

# Write configs
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD php-fpm/php.ini /usr/local/etc/php/conf.d/php.ini

RUN rm -rf /var/www/* \
    && chown -R www-data:www-data /var/www/

VOLUME /var/www/
WORKDIR /var/www/

#cleaning
RUN apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /usr/src/* \
    && rm -rf /usr/share/doc

RUN rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* \
    && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

#install bower
RUN npm install -g bower

# install x-debug
RUN cd /usr/src/php/ext \
    && wget http://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz \
    && tar -xzf xdebug-$XDEBUG_VERSION.tgz \
    && cd xdebug-$XDEBUG_VERSION \
    && phpize \
    && ./configure --enable-xdebug\
    && make && make install \
    && cd .. \
    && docker-php-ext-install xdebug-$XDEBUG_VERSION \
    && rm -rf xdebug-$XDEBUG_VERSION.tgz

CMD ["php-fpm"]