FROM php:8.3-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_pgsql intl xml

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/composer

RUN apt update && apt install -yqq nodejs npm && apt install make

ARG name
ENV DOCKER_ENV $name

COPY ../.. /var/www/
COPY ./.env.${DOCKER_ENV} /var/www/.env
COPY ./docker/global/apache.conf /etc/apache2/sites-available/000-default.conf
RUN chmod -R 777 /var/www/

WORKDIR /var/www/

ENTRYPOINT ["bash", "./docker/global/deploy.sh"]

EXPOSE 80