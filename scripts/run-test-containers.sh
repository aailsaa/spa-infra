#!/bin/bash

echo "Running containers on EC2..."

docker save spa-backend | ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP "sudo docker load"
docker save spa-frontend | ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP "sudo docker load"

scp -o StrictHostKeyChecking=no spa-app/docker-compose.deploy.yml ec2-user@$EC2_IP:docker-compose.yml

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << EOF

cat <<ENV > .env
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
DB_URL=$DB_URL
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
ENV

cat .env

sudo docker-compose up -d

sudo docker ps
sudo docker images

sudo docker logs ec2-user-backend-1 --tail 50
sudo docker logs ec2-user-frontend-1 --tail 50

EOF
