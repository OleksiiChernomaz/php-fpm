#docker build -t oleksiichernomaz/php-fpm:5.6 .
FROM php:5.6-fpm
MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
LABEL version="1.1.1"

ENV XDEBUG_VERSION 2.3.3
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

# install x-cache
RUN cd /usr/src/php/ext \
    && wget http://xcache.lighttpd.net/pub/Releases/$XCACHE_VERSION/xcache-$XCACHE_VERSION.tar.gz \
    && tar -xzf xcache-$XCACHE_VERSION.tar.gz \
    && cd xcache-$XCACHE_VERSION \
    && phpize \
    && ./configure --enable-xcache --enable-xcache-coverager\
    && make && make install \
    && cd .. \
    && docker-php-ext-install xcache-$XCACHE_VERSION \
    && rm -rf xcache-$XCACHE_VERSION.tar.gz \
    && sed -i 's/zend_extension/extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xcache.ini

# Install geoIp
RUN apt-get install -y geoip-bin geoip-database libgeoip-dev \
    && wget https://pecl.php.net/get/geoip-$GEOIP_VERSION.tgz \
    && tar -xzf geoip-$GEOIP_VERSION.tgz \
    && cd geoip-$GEOIP_VERSION \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf geoip-$GEOIP_VERSION.tgz \
    && echo "extension=geoip.so" >> /usr/local/etc/php/conf.d/docker-php-ext-geoip.ini \
    && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
    && gunzip GeoLiteCity.dat.gz \
    && mv -v GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat

# install redis
RUN cd /usr/src/php/ext \
    && git clone https://github.com/phpredis/phpredis.git redis \
    && cd redis \
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
ADD php-fpm/x-cache.conf /usr/local/etc/php/conf.d/docker-php-ext-xcache-$XCACHE_VERSION.ini
ADD php-fpm/geoip.conf /usr/local/etc/php/conf.d/docker-php-ext-geoip-$GEOIP_VERSION.ini
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

CMD ["php-fpm"]