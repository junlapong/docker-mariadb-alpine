MariaDB Docker Image With Alpine Linux
======================================

Lightweight MariaDB docker image with latest stable version of Alpine Linux. Just ~55MB.

The setup script is based on [official MariaDB docker image](https://hub.docker.com/_/mariadb/), so the usage is the same.

## LICENSE

MIT License

```
docker build -t junlapong/alpine-mariadb .

docker run --name mariadb -p 4306:3306 junlapong/alpine-mariadb

docker run --name mariadb \
       -it \
       -v $(pwd)/data:/var/lib/mysql \
       -e MYSQL_DATABASE=testdb \
       -e MYSQL_USER=username \
       -e MYSQL_PASSWORD=password \
       -e MYSQL_ROOT_PASSWORD=rootpass \
       junlapong/alpine-mariadb
```