#!/bin/bash

echo "Installing Docker..."

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << 'EOF'

sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

EOF
