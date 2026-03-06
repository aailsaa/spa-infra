#!/bin/bash

set -e

echo "Deploying to QA EC2..."

ssh -o StrictHostKeyChecking=no ec2-user@$QA_SERVER << EOF

docker pull $ECR_REPO:latest

docker stop spa-app || true
docker rm spa-app || true

docker run -d -p 80:5000 --name spa-app $ECR_REPO:latest

EOF
