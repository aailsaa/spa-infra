#!/bin/bash

echo "Running smoke test against EC2..."

for i in {1..30}; do
  if curl -sf http://$EC2_IP:8080 > /dev/null; then
    echo "Backend is up!"
    exit 0
  fi

  echo "Waiting for backend..."
  sleep 5
done

echo "Smoke test failed"

ssh -i ec2-key.pem ec2-user@$EC2_IP "docker ps"

exit 1
