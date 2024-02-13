FROM php:8.3-apache as php_upstream

# =====================================================================
# PHP BASE IMAGE ======================================================
FROM php_upstream AS php_base

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_pgsql intl xml

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/composer

RUN apt update && \
     apt install -yqq nodejs npm && \
     apt install make && \
     apt-get install -y zip

COPY ../.. /var/www/
COPY docker/global/apache.conf /etc/apache2/sites-available/000-default.conf
RUN chmod -R 777 /var/www/

WORKDIR /var/www/
EXPOSE 80

# =====================================================================
# PHP STAGING IMAGE ===================================================
FROM php_base AS php_staging

COPY ./.env.staging /var/www/.env

ENTRYPOINT ["make", "staging-deploy"]

RUN chmod -R 777 /var/www/
