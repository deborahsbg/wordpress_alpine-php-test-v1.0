#!/bin/bash
set -e

echo "Waiting for WordPress to be ready..."
while ! nc -z wordpress 9000; do
  echo "WordPress is not ready yet. Retrying in 5 seconds..."
  sleep 5
done

echo "WordPress is ready. Starting PHP-FPM on port 9001..."
exec php-fpm --fpm-config /usr/local/etc/php-fpm.conf
