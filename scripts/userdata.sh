#!/bin/bash 
set -xe

# Run docker (backup of AMI)
echo "Running Docker..."
systemctl start docker
systemctl enable docker

docker --version
docker-compose --version

