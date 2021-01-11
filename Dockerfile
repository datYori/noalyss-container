ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

SHELL [ "/bin/sh", "-xe", "-c" ]

ENV DEBIAN_FRONTEND=noninteractive

RUN set -xe \
    && apt-get update -q \
    && apt-get install -qy --no-install-recommends \
       apache2 \
       postgresql \
       php-pgsql \
       php-bcmath \
       php-gmp \
       php-mbstring \
       php-zip \
       php-gd \
       php-xml \
       php \
       libgd-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD noalyss-7410.tar.gz /tmp/

RUN cp -rvp /tmp/noalyss/ /var/www/html/

RUN chown -R www-data /var/www/html/noalyss

RUN chown www-data /var/www/html/noalyss/include/constant.php

USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER noalyss_sql WITH SUPERUSER PASSWORD 'changeit';"

CMD ["apachectl", "-D", "FOREGROUND"]
