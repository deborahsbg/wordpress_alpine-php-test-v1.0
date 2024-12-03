#!/bin/bash

set -e

echo "Stopping and removing existing Docker containers..."
docker-compose down --remove-orphans

echo "Pruning unused Docker objects (volumes, networks, images)..."
docker system prune --volumes --all --force

echo "Building and starting fresh containers..."
docker-compose up --build --force-recreate --detach

echo "Cleaning up dangling images, if any..."
docker image prune --force

echo "Environment deployed successfully."
docker-compose ps

