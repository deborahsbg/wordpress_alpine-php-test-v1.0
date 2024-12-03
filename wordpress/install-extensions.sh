#!/bin/sh
set -eux

# Configure and install PHP extensions
docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
docker-php-ext-install gd intl pdo_mysql zip

# Install Redis extension
pecl install redis
docker-php-ext-enable redis
