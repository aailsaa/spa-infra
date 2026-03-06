#!/bin/bash

set -e

AWS_REGION=$AWS_REGION
ECR_REPO=$ECR_REPO

echo "Logging into ECR..."

aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $ECR_REPO

echo "Tagging image..."

docker tag spa-backend $ECR_REPO_BACKEND:latest
docker tag spa-frontend $ECR_REPO_FRONTEND:latest

echo "Pushing image..."

docker push $ECR_REPO_BACKEND:latest
docker push $ECR_REPO_FRONTEND:latest


