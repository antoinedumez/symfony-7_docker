#!/bin/bash

composer install --no-interaction && \
php bin/console doctrine:migrations:migrate --no-interaction && \
php bin/console cache:clear && \
exec apache2-foreground