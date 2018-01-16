FROM oleksiichernomaz/php-fpm:7.1
# Install modules
RUN export PHPUNIT_VERSION=6.4 \
    && export XDEBUG_VERSION=2.5.5 \
&& apk add --update-cache --upgrade \
    autoconf \
    build-base \
    htop vim git \
    ca-certificates \
    openssl \
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
# inject default config
ADD php-fpm/php.ini /usr/local/etc/php/conf.d/php.ini
EXPOSE 9000
CMD ["php-fpm"]
