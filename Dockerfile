#MAINTAINER Oleksii Chernomaz <alex.chmz@gmail.com>
FROM oleksiichernomaz/php-fpm:7.1

# Install modules
RUN export PHPUNIT_VERSION=6.1 \
    && export XDEBUG_VERSION=2.5.3 \

&& pecl channel-update pecl.php.net \
&& apt-get update && apt-get install -y --force-yes --no-install-recommends \
        vim wget git \

#install xdebug
&& pecl channel-update pecl.php.net \
    && pecl install --onlyreqdeps xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug \

#install composer
&& su && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && exit \

# install phpunit
&& wget https://phar.phpunit.de/phpunit-$PHPUNIT_VERSION.phar \
    && chmod +x phpunit-$PHPUNIT_VERSION.phar \
    && mv phpunit-$PHPUNIT_VERSION.phar /usr/local/bin/phpunit \
    && phpunit --version \

#cleaning
&& apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y --force-yes \
    && apt-get --purge remove tex.\*-doc$ \
    && apt-get remove --purge texlive-fonts-recommended-doc texlive-latex-base-doc texlive-latex-extra-doc \
      texlive-latex-recommended-doc texlive-pictures-doc texlive-pstricks-doc \
&& rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /usr/src/* \
&& rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* \
    && rm -rf /usr/share/lintian/* /usr/share/linda/*

VOLUME /var/www/
WORKDIR /var/www/

EXPOSE 9000

CMD ["php-fpm"]