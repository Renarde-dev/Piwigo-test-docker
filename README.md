# Docker PIWIGO Test :

## Architeture

- MySQL container
- Alpine nginx + php-fpm

## Usage

Edit `compose.yml` and change the MYSQL environment variables :

```yaml
environment:
      - MYSQL_USER=<USERNAME>
      - MYSQL_PASSWORD=<USER_PASSWORD>
      - MYSQL_DATABASE=<DATABASE>
```
You may also want to change the exposed port, this guide assume `8080`.


Starting the container :
```sh
docker compose build
docker compose up -d
```

Go to `my-server:8080`,  
if a warning about permission issues appear you can run :
```sh 
sudo chmod -R 777 ./piwigo-data/{config/,_data/,galleries/,upload/}
```

Fill out the form using `piwigo-db:3306` as database url.

## Updating 

```sh
docker compose down
docker compose pull
docker compose up -d
```

## Advanced options 

### Removing the MySQL container

You can replace the mysql container by any other mysql database that is reachable by the host 

```yaml
# compose.yaml
services:
  piwigo-backend:
    build: ./
    ports:
      - '8080:80'
    volumes:
      - ./piwigo-data/_data:/var/www/html/piwigo/_data
      - ./piwigo-data/upload:/var/www/html/piwigo/upload
      - ./piwigo-data/galleries:/var/www/html/piwigo/galleries
      - ./piwigo-data/config:/var/www/html/piwigo/local/config
```