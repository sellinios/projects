#!/bin/bash

# Define your Docker Hub username and password
DOCKER_HUB_USERNAME="sellinios"
DOCKER_HUB_PASSWORD="faidra123!@#"

# Log in to Docker Hub
echo "Logging in to Docker Hub"
echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin

# Build and push backend Docker image
echo "Building and pushing backend Docker image"
docker build -t $DOCKER_HUB_USERNAME/backend:latest -f Dockerfile.backend .
docker push $DOCKER_HUB_USERNAME/backend:latest

# Build and push frontend Docker image
echo "Building and pushing frontend Docker image"
docker build -t $DOCKER_HUB_USERNAME/frontend:latest -f Dockerfile.frontend .
docker push $DOCKER_HUB_USERNAME/frontend:latest

# Ensure the frontend build output is ready
if [ ! -d "aethra-frontend/build" ]; then
  echo "Frontend build directory not found!"
  exit 1
fi

# Build and push Nginx Docker image
echo "Building and pushing Nginx Docker image"
docker build -t $DOCKER_HUB_USERNAME/nginx:latest -f Dockerfile.nginx .
docker push $DOCKER_HUB_USERNAME/nginx:latest

# Ensure Minikube is running without root
echo "Starting Minikube"
minikube start --driver=docker

# Enable the NGINX Ingress controller
echo "Enabling NGINX Ingress controller"
minikube addons enable ingress

# Set the Minikube context
kubectl config use-context minikube

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests"
kubectl apply -f k8s/backend/backend-deployment.yaml
kubectl apply -f k8s/backend/backend-service.yaml
kubectl apply -f k8s/frontend/frontend-deployment.yaml
kubectl apply -f k8s/frontend/frontend-service.yaml
kubectl apply -f k8s/nginx/nginx-deployment.yaml
kubectl apply -f k8s/nginx/nginx-service.yaml
kubectl apply -f k8s/ingress/ingress.yaml

echo "Deployment complete"
