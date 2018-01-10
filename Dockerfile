#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM php:7.2-fpm-alpine
# Install modules
RUN export REDIS_VERSION=3.1.6 \
    && export GEOIP_VERSION=1.1.1 \
    && export MEMCACHED_VERSION=3.0.4 \
&& apk add --no-cache --upgrade \
    autoconf \
    build-base \
    postgresql-dev \
    libxml2-dev \
    pcre-dev \
&& pecl channel-update pecl.php.net \
## Install additional core extensions
&& docker-php-ext-install \
        pdo \
        bcmath \
        mbstring \
        pdo mysqli \
        pdo_mysql \
        pdo_pgsql\
        soap \
        ftp \
        opcache \
#install redis
&& pecl install redis-$REDIS_VERSION \
    && docker-php-ext-enable redis \
#install geoip
&& apk add --no-cache --upgrade \
        ca-certificates \
        geoip \
        geoip-dev \
        wget \
    && update-ca-certificates \
    && pecl install geoip-$GEOIP_VERSION \
    && docker-php-ext-enable geoip \
    && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
        && gunzip GeoLiteCity.dat.gz \
        && mkdir -p /usr/share/GeoIP \
        && mv GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat \
        && chmod +rx /usr/share/GeoIP/GeoIPCity.dat \
        && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz \
        && gunzip GeoIP.dat.gz \
        && mv GeoIP.dat /usr/share/GeoIP/GeoIP.dat \
        && chmod +rx /usr/share/GeoIP/GeoIP.dat \
#install memcached
&& apk add --no-cache --upgrade \
        libmemcached-dev \
        cyrus-sasl-dev \
    && pecl install memcached-$MEMCACHED_VERSION \
    && docker-php-ext-enable memcached \
#install gd
&& apk add --no-cache \
    libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev \
    && docker-php-ext-install gd \
# cleanup
&& apk del \
    autoconf \
    build-base \
    wget
# Write configs #and override it via: /usr/local/configs/php/
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD configs/php.ini /usr/local/etc/php/conf.d/php.ini
ADD configs/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
# define a volume + working dir
VOLUME /var/www/
WORKDIR /var/www/
EXPOSE 9000
CMD ["php-fpm"]
