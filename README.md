# Docker PIWIGO Test :

## Architeture

- MySQL container
- Alpine nginx + php-fpm

Sources used when making this :

https://github.com/TrafeX/docker-php-nginx

https://github.com/linuxserver/docker-piwigo/blob/master/Dockerfile

## Running


```sh
docker compose build
docker compose up -d
```
