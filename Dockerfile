#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM php:7.1-fpm-alpine

# Install modules
RUN export REDIS_VERSION=3.1.3 \
    && export APCu_VERSION=5.1.8 \
    && export APCU_BC_VERSION=1.0.3 \
    && export GEOIP_VERSION=1.1.1 \
&& apk add --update-cache --upgrade \
    autoconf \
    build-base \
    openssl-dev \
    postgresql-dev \
    libxml2-dev \
    geoip \
    geoip-dev \
    pcre-dev \
&& pecl channel-update pecl.php.net \

## Install additional core extensions
&& docker-php-ext-install \
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
&& pecl install geoip-$GEOIP_VERSION \
    && docker-php-ext-enable geoip \

#install apc+apcu
&& pecl install apcu-$APCu_VERSION \
    && pecl install --onlyreqdeps apcu_bc-$APCU_BC_VERSION \
    && docker-php-ext-enable apcu \

# cleanup
&& apk del \
    autoconf \
    build-base

# Write configs #and override it via: /usr/local/configs/php/
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD configs/php.ini /usr/local/etc/php/conf.d/php.ini
ADD configs/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# define a volume + working dir
VOLUME /var/www/
WORKDIR /var/www/

EXPOSE 9000

CMD ["php-fpm"]
