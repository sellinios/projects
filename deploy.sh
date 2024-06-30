#!/bin/bash

# Ensure the necessary directories exist
mkdir -p aethra-frontend/config/ssl
mkdir -p aethra-frontend/config/nginx

# Temporarily adjust permissions to read the SSL files
chmod 644 /etc/letsencrypt/live/kairos.gr/fullchain.pem
chmod 644 /etc/letsencrypt/live/kairos.gr/privkey.pem

# Copy the SSL certificates
cp /etc/letsencrypt/live/kairos.gr/fullchain.pem aethra-frontend/config/ssl/fullchain.pem
cp /etc/letsencrypt/live/kairos.gr/privkey.pem aethra-frontend/config/ssl/privkey.pem

echo "SSL certificates have been copied to config/ssl"

# Verify nginx.conf exists
if [ ! -f aethra-frontend/config/nginx/nginx.conf ]; then
    echo "config/nginx/nginx.conf not found. Exiting."
    exit 1
fi

echo "nginx.conf found. Proceeding with Docker build..."

# Stop and remove any existing containers
docker-compose down

# Build and start the containers
docker-compose up -d --build

# Clean up dangling images
docker image prune -f

echo "Deployment complete."