#!/bin/bash

set -e

QA_SERVER=$1

echo "Deploying to QA EC2: $QA_SERVER"

ssh -o StrictHostKeyChecking=no ec2-user@$QA_SERVER << EOF

docker pull $ECR_REPO:latest

docker stop spa-app || true
docker rm spa-app || true

docker run -d -p 80:5000 --name spa-app $ECR_REPO:latest

EOF
