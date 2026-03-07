#!/bin/bash

set -e

QA_SERVER=$1
ECR_REPO=$2

echo "Deploying SPA to QA EC2: $QA_SERVER"

ssh -T -o StrictHostKeyChecking=no ec2-user@$QA_SERVER << EOF

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
  -p 8080:8080 \
  --name backend \
  $ECR_REPO:backend

echo "Starting frontend..."

docker run -d \
  -p 80:3000 \
  --name frontend \
  $ECR_REPO:frontend

echo "QA deployment complete."

EOF
