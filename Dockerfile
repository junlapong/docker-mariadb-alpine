FROM alpine:latest

#ENV LC_ALL=en_GB.UTF-8
ENV TZ "Asia/Bangkok"

RUN apk -U upgrade && \
    apk add bash tzdata mariadb mariadb-client

RUN ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && date

RUN mkdir /docker-entrypoint-initdb.d

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf && \
    echo -e 'skip-host-cache\nskip-name-resolve' | \
    awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' \
    /etc/mysql/my.cnf > /tmp/my.cnf && \
    mv /tmp/my.cnf /etc/mysql/my.cnf

RUN rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3306
