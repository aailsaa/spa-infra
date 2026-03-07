#!/bin/bash

set -e

QA_SERVER=$1
ECR_REPO=$2

echo "Deploying SPA to QA EC2: $QA_SERVER"

ssh -vvv -T -o StrictHostKeyChecking=no ec2-user@$QA_SERVER << EOF

aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin $ECR_REPO

echo "Pulling latest images from ECR..."

docker pull $ECR_REPO:frontend
docker pull $ECR_REPO:backend

echo "Stopping old containers..."

docker stop frontend || true
docker rm frontend || true

docker stop backend || true
docker rm backend || true

echo "Starting backend..."

docker run -d \
-p 5000:8080 \
--name backend \
-e DB_URL="$DB_URL" \
-e DB_USERNAME="$DB_USERNAME" \
-e DB_PASSWORD="$DB_PASSWORD" \
$ECR_REPO:backend

echo "Starting frontend..."

docker run -d \
-p 80:80 \
--name frontend \ 
$ECR_REPO:frontend

echo "QA deployment complete."

EOF
