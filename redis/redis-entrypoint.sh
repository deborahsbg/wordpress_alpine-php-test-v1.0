#!/bin/sh
set -e

# Check for the Redis password secret
if [ ! -f /run/secrets/redis_password ]; then
  echo "Error: Redis password secret not found!"
  exit 1
fi

# Load the Redis password
REDIS_PASSWORD=$(cat /run/secrets/redis_password)

# Update redis.conf dynamically to inject the password
if grep -q "^requirepass" /usr/local/etc/redis/redis.conf; then
  # Update existing requirepass line if it exists
  sed -i "s/^requirepass.*/requirepass $REDIS_PASSWORD/" /usr/local/etc/redis/redis.conf
else
  # Add requirepass line if it doesn't exist
  echo "requirepass $REDIS_PASSWORD" >> /usr/local/etc/redis/redis.conf
fi

# Start Redis with the specified configuration file
exec redis-server /usr/local/etc/redis/redis.conf

