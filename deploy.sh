#!/bin/bash

# Exit on any error
set -e

# Configuration
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
ECR_REPOSITORY="matchderport/mdp-backend"
IMAGE_TAG="latest"
CONTAINER_NAME="grace-batch-app"

echo "Starting deployment..."

# Login to ECR
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}

# Pull the latest image
echo "Pulling latest image..."
docker pull ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

# Stop and remove existing container
echo "Stopping existing container..."
docker stop ${CONTAINER_NAME} || true
docker rm ${CONTAINER_NAME} || true

# Clean up old images
docker system prune -f

# Run the new container
echo "Starting new container..."
docker run -d \
  --name ${CONTAINER_NAME} \
  -p 8000:8000 \
  --restart unless-stopped \
  ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

echo "Deployment completed successfully!"