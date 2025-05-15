# Docker PIWIGO Test :

An alpine based container to easily deploy piwigo.

## Usage

### Setup

Create a folder named `Piwigo` in `$HOME` and copy `compose.yaml` from this repository, then create a `.env` file :

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
Go to `my-server:8080` and complete the installation.  
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

### Advanced option

if you want to use an existing MySQL/MariaDB database you already setup, rename `compose-nodb.yaml` as `compose.yaml`

if preffer using a `mysql` container edit `compose.yaml` and replace mariadb by mysql (case sensitive).

## Architeture

- MariaDB container, data is stored `/piwigo-data/mysql`
- Alpine nginx + php-fpm

PHP modules are installed with alpine natives packages, php-fpm is running with the same user as nginx.