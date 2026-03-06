#!/bin/bash
set -e

echo "Launching temporary EC2..."

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-0c02fb55956c7d316 \
  --instance-type t2.micro \
  --security-group-ids $EC2_SECURITY_GROUP \
  --subnet-id $EC2_SUBNET \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance ID: $INSTANCE_ID"

echo "Waiting for EC2 to start..."

aws ec2 wait instance-running --instance-ids $INSTANCE_ID

IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "EC2_IP=$IP" >> $GITHUB_ENV
echo "INSTANCE_ID=$INSTANCE_ID" >> $GITHUB_ENV
