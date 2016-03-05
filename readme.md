# php-fpm
Do not forget to authorize on docker server before pushing data:
```
vagrant@vagrant-ubuntu-trusty-64:/docker/brainstorms$ sudo docker login --username=oleksiichernomaz --email=alex.chmz@gmail.com
Password:
WARNING: login credentials saved in /home/vagrant/.docker/config.json
Login Succeeded
```

To build image in current folder run command
```
    docker build -t oleksiichernomaz/php-fpm:5.6 .
```
## Build _2.1.1_ includes ##

* php-fpm:7.0
* mysql support
* pgsql support
* x-debug
* vim
* wget
* npm
* composer
* bower
* uglify-js\css

Removed:

* x-cache
* geoIp library

## Build _1.1.1_ includes: ##

* php-fpm:5.6
* mysql support
* pgsql support
* x-debug
* x-cache
* geoIp library
* vim
* wget
* npm
* composer
* bower
* uglify-js\css

Web dir:
```/var/www/```