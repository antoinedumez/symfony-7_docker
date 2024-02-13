#!/bin/bash

composer install --no-interaction && \
php bin/console doctrine:migrations:migrate --no-interaction && \
php bin/console cache:clear && \
php bin/console tailwind:build --minify && \
php bin/console asset-map:compile && \
chmod -R 777 /var/www/ && \
exec apache2-foreground