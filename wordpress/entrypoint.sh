#!/bin/bash
set -e

# Debugging: Show database environment variables
echo "DB_HOST: ${WORDPRESS_DB_HOST}"
echo "DB_NAME: ${WORDPRESS_DB_NAME}"
echo "DB_USER: ${WORDPRESS_DB_USER}"
echo "DB_PASSWORD_FILE content: $(cat /run/secrets/db_password)"

# Wait for the database
echo "Waiting for database..."
until mysqladmin ping -h "${WORDPRESS_DB_HOST}" --silent; do
  echo "Database is not ready. Retrying in 5 seconds..."
  sleep 5
done
echo "Database is ready."

# Download WordPress core if not already present
if [ ! -f /var/www/html/wp-config-sample.php ]; then
  echo "Downloading WordPress core..."
  wp core download --allow-root --path=/var/www/html
fi

# Ensure wp-config.php exists
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Creating wp-config.php..."
  wp config create \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="$(cat /run/secrets/db_password)" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --allow-root --path=/var/www/html
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root --path=/var/www/html; then
  echo "Installing WordPress..."
  echo "Using admin email: ${WP_ADMIN_EMAIL:-deborahsbeghen@gmail.com}" # Debugging email
  wp core install \
    --url="${WP_SITE_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="$(cat /run/secrets/wp_admin_password)" \
    --admin_email="${WP_ADMIN_EMAIL:-deborahsbeghen@gmail.com}" \
    --allow-root --path=/var/www/html
fi

# Plugin installation and activation
if [ -f /var/www/html/plugins.txt ]; then
  echo "Installing and activating plugins from plugins.txt..."
  while IFS= read -r PLUGIN || [ -n "$PLUGIN" ]; do
    if ! wp plugin is-installed "$PLUGIN" --allow-root --path=/var/www/html; then
      echo "Installing plugin: $PLUGIN"
      wp plugin install "$PLUGIN" --allow-root --path=/var/www/html
    fi
    echo "Activating plugin: $PLUGIN"
    wp plugin activate "$PLUGIN" --allow-root --path=/var/www/html
  done < /var/www/html/plugins.txt
else
  echo "No plugins.txt file found. Skipping plugin installation."
fi

exec "$@"

