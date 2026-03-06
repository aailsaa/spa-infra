#!/bin/bash

echo "Running containers on EC2..."

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << EOF

docker run -d -p 8080:8080 spa-backend
docker run -d -p 3000:3000 spa-frontend

EOF
