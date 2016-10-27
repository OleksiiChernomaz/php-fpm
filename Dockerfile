#docker build -t oleksiichernomaz/php-fpm:7.0 .
#sudo docker push oleksiichernomaz/php-fpm:7.0
#docker run -it oleksiichernomaz/php-fpm:7.0 bash

#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM php:7.0-fpm

# Install modules
RUN export APCU_VERSION=5.1.7 \
    && export APCU_BC_VERSION=1.0.3 \
&& apt-get update && apt-get install -y --force-yes \
        vim wget git\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libpq-dev \
        libgearman-dev \
        libphp-predis \
# Install additional core extensions
&& docker-php-ext-install \
        mbstring \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip \
        opcache \
        mcrypt \
# Install GD
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd \

# install redis
&& cd /usr/src/php/ext \
    && git clone https://github.com/phpredis/phpredis.git redis \
    && cd redis \
    && git checkout php7 \
    && phpize \
    && ./configure --enable-redis \
    && cd .. \
    && docker-php-ext-install redis \

#install apcu
&& cd /usr/src/php/ext \
    && wget https://pecl.php.net/get/apcu-$APCU_VERSION.tgz \
    && tar -xzf apcu-$APCU_VERSION.tgz  \
    && cd apcu-$APCU_VERSION \
    && phpize \
    && ./configure --enable-apcu\
    && make && make install \
    && cd .. \
    && docker-php-ext-install apcu-$APCU_VERSION \
    && rm -rf apcu-$APCU_VERSION.tgz \

#install apcu-bc (apc support)
&& cd /usr/src/php/ext \
    && wget https://pecl.php.net/get/apcu_bc-$APCU_BC_VERSION.tgz \
    && tar -xzf apcu_bc-$APCU_BC_VERSION.tgz  \
    && cd apcu_bc-$APCU_BC_VERSION \
    && phpize \
    && ./configure --enable-apcu-bc\
    && make && make install \
    && cd .. \
    && docker-php-ext-install apcu_bc-$APCU_BC_VERSION \
    && rm -rf apcu_bc-$APCU_BC_VERSION.tgz \

&& rm -rf /var/www/* \
    && chown -R www-data:www-data /var/www/ \

#cleaning
&& apt-get --purge -y --force-yes remove wget git vim \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y --force-yes \

&& rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /usr/src/* \
    && rm -rf /usr/share/doc \

&& rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* \
    && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

# Write configs
ADD php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD php-fpm/php.ini /usr/local/etc/php/conf.d/php.ini

VOLUME /var/www/
WORKDIR /var/www/

CMD ["php-fpm"]