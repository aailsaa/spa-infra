#!/bin/bash -xe

yum update -y

# Install Docker
yum install -y docker

systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 \
-o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
/usr/local/bin/docker-compose --version
