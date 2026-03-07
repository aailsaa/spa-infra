#!/bin/bash -xe
yum update -y

# Install Docker
yum install -y docker

# Start Docker
systemctl start docker
systemctl enable docker

# Allow ec2-user to run Docker
usermod -aG docker ec2-user
