# php-fpm

### version
```
PHP 7.1.5 (cli) (built: May 13 2017 00:18:23) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.5, Copyright (c) 1999-2017, by Zend Technologies
```

### modules

```
[PHP Modules]
apcu
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
ftp
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

- checkout appropriate branch
- make sure that you have the latest changes from the branch
- make all the changes, create pull request

```
docker build --compress --pull --force-rm --squash --tag oleksiichernomaz/php-fpm:7.1 .
docker push oleksiichernomaz/php-fpm:7.1
```