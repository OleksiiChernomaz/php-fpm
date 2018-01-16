FROM php:7.1-fpm-alpine
# Install modules
RUN export REDIS_VERSION=3.1.4 \
    && export GEOIP_VERSION=1.1.1 \
&& apk add --no-cache --upgrade \
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
    && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
    && gunzip GeoLiteCity.dat.gz \
    && mkdir -p /usr/share/GeoIP \
    && mv GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat \
    && chmod +rx /usr/share/GeoIP/GeoIPCity.dat \
    && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz \
    && gunzip GeoIP.dat.gz \
    && mv GeoIP.dat /usr/share/GeoIP/GeoIP.dat \
    && chmod +rx /usr/share/GeoIP/GeoIP.dat \
# cleanup
&& apk del \
    autoconf \
    build-base
# Write default configs, override it via: /usr/local/configs/php/
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD php-fpm/php.ini /usr/local/etc/php/conf.d/php.ini
# define a volume + working dir
VOLUME /var/www/
WORKDIR /var/www/
EXPOSE 9000
CMD ["php-fpm"]
