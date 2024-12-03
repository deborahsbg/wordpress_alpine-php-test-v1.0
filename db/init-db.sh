#!/bin/bash
set -e

# Start MariaDB in the background
docker-entrypoint.sh mysqld &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h localhost --silent; do
  sleep 2
done
echo "MariaDB is ready."

# Read the database password
DB_PASSWORD=$(cat /run/secrets/db_password)

# Create the WordPress database if it doesn't exist
echo "Ensuring database 'casbeghen_db' exists..."
mysql -u root -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS casbeghen_db;"

# Grant privileges to the root user
echo "Granting privileges to root user..."
mysql -u root -p"$DB_PASSWORD" -e "GRANT ALL PRIVILEGES ON casbeghen_db.* TO 'root'@'%'; FLUSH PRIVILEGES;"

# Wait for the main MariaDB process
wait

