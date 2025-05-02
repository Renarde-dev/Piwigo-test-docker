# Multi container : 

Nginx act as the reverse proxy to secure fpm.  
MySQL is the database, isolated and inacessible outside the internal container network.  
php-fpm-alpine is a FPM enabled container based on alpine making it much faster and lighter than it's debian counterpart.

- [MySQL](https://hub.docker.com/_/mysql/)
- [Nginx](https://hub.docker.com/_/nginx)
- [php-fpm-alpine](https://hub.docker.com/_/php/)