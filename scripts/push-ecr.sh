#!/bin/bash

set -e

AWS_REGION=$AWS_REGION
ECR_REPO=$ECR_REPO

echo "Logging into ECR..."

aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $ECR_REPO

echo "Tagging image..."

docker tag spa-app:latest $ECR_REPO:latest

echo "Pushing image..."

docker push $ECR_REPO:latest
