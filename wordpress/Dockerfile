# Use the official WordPress image with PHP-FPM and Alpine Linux
FROM wordpress:php8.3-fpm-alpine

# Install necessary packages
RUN apk add --no-cache \
    bash \
    mariadb-client \
    curl \
    unzip \
    tar \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    zlib-dev \
    icu-libs \
    icu-dev \
    autoconf \
    make \
    gcc \
    g++ \
    && docker-php-source extract

# Copy the install-extensions script to the image
COPY install-extensions.sh /usr/local/bin/install-extensions.sh

# Run the extension installation script
RUN chmod +x /usr/local/bin/install-extensions.sh && /usr/local/bin/install-extensions.sh

# Remove build dependencies and temporary files to minimize image size
RUN docker-php-source delete \
    && apk del autoconf make gcc g++

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set proper permissions for WordPress
RUN mkdir -p /var/www/html/wp-content/uploads \
    && chmod -R 775 /var/www/html/wp-content/uploads \
    && chown -R www-data:www-data /var/www/html

# Copy entrypoint script and ensure it's executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose WordPress PHP-FPM port
EXPOSE 9000

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Start PHP-FPM by default
CMD ["php-fpm"]

