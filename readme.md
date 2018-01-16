# php-fpm. 

>### Notes about the images:
>
> All versions with suffix `-dev` contain additionally on the top of parent image `xdebug`, `composer`, `phpunit`.
>
>Note that you have to adjust default configuration for your needs before it goes to production. 
>You can put your configs into the file `/usr/local/etc/php/conf.d/php.ini` or inject it with `nginx`.
>
>Web directory as in the `/var/www/`
>Config directories are: `.:/usr/local/etc/php/conf.d/:/usr/local/etc/php/*.ini`

# version 7.2.X

```
PHP 7.2.1 (cli) (built: Jan 10 2018 02:33:50) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.2.1, Copyright (c) 1999-2017, by Zend Technologies
```

#### modules

```
[PHP Modules]
bcmath, Core, ctype, curl, date, dom, fileinfo, filter, ftp, 
gd, geoip, hash, iconv, json, libxml, mbstring, memcached, mysqli, 
mysqlnd, openssl, pcre, PDO, pdo_mysql, pdo_pgsql, pdo_sqlite, Phar, 
posix, readline, redis, Reflection, session, SimpleXML, soap, SPL, sqlite3, 
standard, tokenizer, xml, xmlreader, xmlwriter, Zend OPcache, zlib, 

[Zend Modules]
Zend OPcache
```
----------
# version 7.2.X-dev

```
PHP 7.2.1 (cli) (built: Jan 10 2018 02:33:50) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.2.1, Copyright (c) 1999-2017, by Zend Technologies
    with Xdebug v2.6.0beta1, Copyright (c) 2002-2017, by Derick Rethans
```

#### modules

```
[PHP Modules]
bcmath, Core, ctype, curl, date, dom, fileinfo, filter, ftp, 
gd, geoip, hash, iconv, json, libxml, mbstring, memcached, mysqli, 
mysqlnd, openssl, pcre, PDO, pdo_mysql, pdo_pgsql, pdo_sqlite, Phar, 
posix, readline, redis, Reflection, session, SimpleXML, soap, SPL, sqlite3, 
standard, tokenizer, xdebug, xml, xmlreader, xmlwriter, Zend OPcache, zlib, 

[Zend Modules]
Xdebug, Zend OPcache
```
----------
# version 7.1.X

```
PHP 7.1.13 (cli) (built: Jan 10 2018 03:09:34) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.13, Copyright (c) 1999-2017, by Zend Technologies
```

#### modules

```
[PHP Modules]
bcmath, Core, ctype, curl, date, dom, fileinfo, 
filter, ftp, geoip, hash, iconv, json, libxml, 
mbstring, mysqli, mysqlnd, openssl, pcre, PDO, 
pdo_mysql, pdo_pgsql, pdo_sqlite, Phar, posix, 
readline, redis, Reflection, session, SimpleXML, 
soap, SPL, sqlite3, standard, tokenizer, xml, 
xmlreader, xmlwriter, Zend OPcache, zlib, 

[Zend Modules]
Zend OPcache
```

----------
# version 7.1.X-dev

```
PHP 7.1.13 (cli) (built: Jan 10 2018 03:09:34) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.13, Copyright (c) 1999-2017, by Zend Technologies
    with Xdebug v2.5.5, Copyright (c) 2002-2017, by Derick Rethans
```

#### modules

```
[PHP Modules]
bcmath, Core, ctype, curl, date, dom, fileinfo, filter, ftp, 
geoip, hash, iconv, json, libxml, mbstring, mysqli, mysqlnd, openssl, pcre, 
PDO, pdo_mysql, pdo_pgsql, pdo_sqlite, Phar, posix, readline, redis, 
Reflection, session, SimpleXML, soap, SPL, sqlite3, standard, tokenizer, 
xdebug, xml, xmlreader, xmlwriter, Zend OPcache, zlib, 

[Zend Modules]
Xdebug, Zend OPcache
```

----------
# How to contribute

- checkout your feature branch from the appropriate one
- make sure that you have the latest changes from remote repository
- make all the changes, create pull request, once it get merged, container would be re-deployed


# To test build on local machine, use:

```
docker build --compress --pull --force-rm --tag oleksiichernomaz/php-fpm:7.X .
```
