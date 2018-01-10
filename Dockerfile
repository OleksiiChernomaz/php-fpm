#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM oleksiichernomaz/php-fpm:7.2
# Install modules
RUN export PHPUNIT_VERSION=6.4 \
    && export XDEBUG_VERSION=2.6.0beta1 \
&& apk add --update-cache --upgrade \
    autoconf \
    build-base \
    htop vim git \
    ca-certificates \
    wget \
    openssl \
&& pecl channel-update pecl.php.net \
#install xdebug
&& pecl channel-update pecl.php.net \
    && pecl install --onlyreqdeps xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug \
#install composer
&& curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
#install phpunit
&& wget https://phar.phpunit.de/phpunit-$PHPUNIT_VERSION.phar \
    && chmod +x phpunit-$PHPUNIT_VERSION.phar \
    && mv phpunit-$PHPUNIT_VERSION.phar /usr/local/bin/phpunit \
# cleanup
&& apk del \
    autoconf \
    build-base
EXPOSE 9000
CMD ["php-fpm"]
