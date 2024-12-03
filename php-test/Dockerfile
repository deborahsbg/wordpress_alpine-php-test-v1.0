# Use PHP 8.2 FPM base image
FROM php:8.2-fpm-alpine

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    bash \
    curl \
    zlib-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd

# Set working directory
WORKDIR /var/www/html/php-test

# Add entrypoint script
COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Expose PHP-FPM port for php-test
EXPOSE 9001

# Default command
CMD ["php-fpm"]

