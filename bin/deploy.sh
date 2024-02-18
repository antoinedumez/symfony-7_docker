#!/bin/bash

composer install --no-interaction && \
php bin/console doctrine:migrations:migrate --no-interaction && \
php bin/console tailwind:build -m && \
php bin/console cache:clear