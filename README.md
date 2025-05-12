# Docker PIWIGO Test :

A container to deploy piwigo

## Usage

### Setup

Create a folder and copy `compose.yaml`, then create a `.env` file :  


```sh
db_user=            # Database user ex : PiwigoDB_user
db_user_password=   # Database user password ex: MyPasswd
db_name=            # Database name : PiwigoDB
piwigo_port=        # Port exposed ex : 8080
```

Start the container with `docker compose up -d`  
Go to `my-server:8080` and complete the installation.

> if a warning about permission issues appear you can run : 
>```sh
>sudo chmod 777 -R ./piwigo-data/{config/,_data/,galleries/,upload/}
>```

Fill out the form using `piwigo-db:3306` as database url and the info you filled out in the `.env` file.

### Updating 

```sh
docker compose down
docker compose pull
docker compose up -d
```

### Advanced option

if you want to use an existing MySQL/MariaDB database you already setup use the `compose-nodb.yaml` file, rename it to `compose.yaml`  
You only have to specify the exposed port (`piwigo_port`) in `.env`.

if preffer using a `mysql` container edit `compose.yaml` and replace mariadb by mysql (case sensitive).

## Architeture

- MariaDB container, data is stored `/piwigo-data/mysql`
- Alpine nginx + php-fpm