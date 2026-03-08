#!/bin/bash

echo "Running containers on EC2..."

# Copy project files to EC2
scp -r -o StrictHostKeyChecking=no spa-app ec2-user@$EC2_IP:~

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << EOF

cd ~/spa-app

# Create environment file
cat <<ENV > .env
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
DB_URL=$DB_URL
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
ENV

echo "Environment variables:"
cat .env

echo "Building containers..."
sudo docker compose build

echo "Starting containers..."
sudo docker compose up -d

echo "Running containers:"
sudo docker ps

echo "Docker images:"
sudo docker images

echo "Backend logs:"
sudo docker logs backend --tail 50 || true

echo "Frontend logs:"
sudo docker logs frontend --tail 50 || true

EOF
