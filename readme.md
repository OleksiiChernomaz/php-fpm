# php-fpm

All version with suffix `-dev` contain additionally on the top of parent image `xdebug`, by default display errors, etc..

# version 7.1.X
```
PHP 7.1.13 (cli) (built: Jan 10 2018 03:09:34) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.13, Copyright (c) 1999-2017, by Zend Technologies
```

### modules

```
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
geoip
hash
iconv
json
libxml
mbstring
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
Zend OPcache
```

### Web dir:
```/var/www/```

### Configs directory
```
.:/usr/local/etc/php/conf.d/:/usr/local/etc/php/*.ini
```

# How to contribute

- checkout your feature branch from the appropriate one
- make sure that you have the latest changes from remote repository
- make all the changes, create pull request, once it get merged, container would be re-deployed


# To test build on local machine, use:

```
docker build --compress --pull --force-rm --tag oleksiichernomaz/php-fpm:7.X .
```
