# php-fpm 7.2.x for dev env

### version 
```
PHP 7.2.x (cli) (built: Jan 10 2018 02:33:50) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.2.1, Copyright (c) 1999-2017, by Zend Technologies
    with Xdebug v2.6.0beta1, Copyright (c) 2002-2017, by Derick Rethans
```

### modules

```
/var/www # php -m
[PHP Modules]
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
geoip
hash
iconv
json
libxml
mbstring
memcached
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
Phar
posix
readline
redis
Reflection
session
SimpleXML
soap
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
Zend OPcache
zlib

[Zend Modules]
Xdebug
Zend OPcache

```

### Web dir:
```/var/www/```

### Configs directory
```
.:/usr/local/etc/php/conf.d/:/usr/local/etc/php/*.ini
```

# How to contribute

- checkout appropriate branch
- make sure that you have the latest changes from the branch
- make all the changes, create pull request


# To make a test build on your local machine:

```
docker build --compress --pull --force-rm --squash --tag oleksiichernomaz/php-fpm:7.2-dev .
docker run -it oleksiichernomaz/php-fpm:7.2-dev
```
