#!/bin/bash 
set -xe

# Run docker (backup of AMI)
echo "Running Docker..."
systemctl start docker
systemctl enable docker

# check if docker is downloaded
docker --version
docker-compose --version

