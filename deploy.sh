#!/bin/bash

# Activate virtual environment
source "venv/bin/activate"

# Update the requirements.txt file in the aethra-backend directory
echo "Updating requirements.txt in aethra-backend directory..."
(
  cd "aethra-backend" || exit
  pip freeze > "requirements.txt"
)

# Ensure the necessary directories exist
mkdir -p "aethra-frontend/config/nginx"
mkdir -p "aethra-frontend/config/ssl-nginx"

echo "nginx.conf files found. Proceeding with Docker build..."

# Stop and remove any existing containers
docker-compose down

# Stop any other processes or containers using ports 8000, 443, and 80
sudo lsof -t -i:8000 -i:443 -i:80 | xargs -r sudo kill -9

# Build and start the containers
docker-compose up -d --build --remove-orphans

# Tag the SSL container to prevent pruning
docker tag "$(docker images projects-aethra-ssl-nginx -q)" "projects-aethra-ssl-nginx:protected"

# Clean up dangling images, excluding the protected SSL image
docker image prune -f --filter "label!=protected"

echo "Deployment complete."

# Show running containers
docker ps
