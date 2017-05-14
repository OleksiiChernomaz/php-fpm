#docker build --compress --pull --force-rm --squash --tag oleksiichernomaz/php-fpm:7.1 .
#docker push oleksiichernomaz/php-fpm:7.1

#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM php:7.1-fpm

# Install modules
RUN export REDIS_VERSION=3.1.2 \
    && export MEMCACHED_VERSION=3.0.3 \
    && export APCu_VERSION=5.1.8 \
    && export APCU_BC_VERSION=1.0.3 \
&& apt-get update && apt-get install -y --no-install-recommends \
        libxml2-dev \
        libssl-dev \
        libmemcached-dev \
&& pecl channel-update pecl.php.net \

# Install additional core extensions
&& docker-php-ext-install \
        bcmath \
        mbstring \
        pdo mysqli pdo_mysql \
        soap \
        ftp \
        opcache \

#install redis
&& pecl install redis-$REDIS_VERSION \

#install apc+apcu
&& pecl install apcu-$APCu_VERSION \
    && pecl install --onlyreqdeps apcu_bc-$APCU_BC_VERSION \
    && echo 'extension = apcu.so' > /usr/local/etc/php/conf.d/apcu.ini \

# install memcached
&& pecl install memcached-$MEMCACHED_VERSION \

&& rm -rf /var/www/* \
    && chown -R www-data:www-data /var/www/ \

#cleaning
&& apt-get --purge -y --force-yes remove libxml2-dev libssl-dev libmemcached-dev \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y --force-yes \
&& rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /usr/src/* \
    && rm -rf /usr/share/doc \
&& rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* \
    && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

# Write configs #and override it via: /usr/local/configs/php/
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD configs/php.ini /usr/local/etc/php/conf.d/php.ini
ADD configs/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

VOLUME /var/www/
WORKDIR /var/www/

EXPOSE 9000

CMD ["php-fpm"]