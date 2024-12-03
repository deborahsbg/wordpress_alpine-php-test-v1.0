#!/bin/sh
echo "Waiting for dependent services..."
for service in wordpress php_test; do
    until curl -sf "http:///health.php"; do
        echo " is not healthy yet. Retrying in 5 seconds..."
        sleep 5
    done
    echo " is healthy!"
done
echo "All services are healthy. Starting Nginx..."
exec nginx -g "daemon off;"
