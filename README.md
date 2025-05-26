# Docker PIWIGO Test :

An alpine based container to easily deploy piwigo.

## Usage

### Setup

Create a folder named `Piwigo` in `$HOME` and copy `compose.yaml` from this repository, then create a `.env` file

```
Piwigo
├── .env
└── compose.yaml
```

Edit `.env` and add a password after `db_user_password=` (you can generate a strong password [here](https://bitwarden.com/password-generator/))

```conf
db_user=piwigodb_user
db_user_password=
db_name=piwigodb
piwigo_port=8080
```

Start the container with `docker compose up -d`  
Go to `my-server-ip:8080` (configure your reverse proxy if needed) and complete the installation.  
Fill out the database form using the following values :
```yaml
Database configuration:
    Host:           piwigo-db:3306
    User:           piwigodb_user
    Password:       #Password in .env
    Database name:  piwigodb
```

### Updating 

```sh
docker compose down # Stop the container
# Backup data
rsync -r --delete-before ./piwigo-data/ ./piwigo-data.bck/ 
# Update and restart the container
docker compose pull
docker compose up -d
```

### Advanced options

if you preffer using a `mysql` container edit `compose.yaml` and replace mariadb by mysql (case sensitive).

if you want to use an existing MySQL/MariaDB database you already setup, use `compose-nodb.yaml` and rename it `compose.yaml`.
You can either create `.env` with `piwigo_port=` or manually edit the compose file to change the exposed port.

You can create a script at `./piwigo-data/scripts/user.sh` to run commands before nginx and php start.  
eg: to install extra dependencies like pandoc `apk add --no-cache pandoc`, available package listed at [alpine pkg index](https://pkgs.alpinelinux.org/packages)

## Architeture

Two container :
- Alpine nginx with php-fpm
- MariaDB

PHP modules are installed with alpine natives packages, php-fpm is running with the same user as nginx.

Container network trafic is internal in the `piwigo-network` bridge.

All persistent data is stored in `./piwigo-data/` :

- `piwigo` piwigo files, when a new version is released, new files will be copied over
- `mysql` database files from the mariaDB/mysql
- `scripts` allow user to sideload dependencies and other files outside of piwigo