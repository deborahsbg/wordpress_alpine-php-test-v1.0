#!/bin/sh
set -e

echo "Starting PHP-FPM on port 9001..."
exec php-fpm --fpm-config /usr/local/etc/php-fpm.conf
