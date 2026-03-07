#!/bin/bash

echo "Running smoke test on EC2..."

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << EOF

echo "Waiting for backend..."
sleep 20

for i in {1..30}; do
  STATUS=$(curl -s -o /dev/null \
    --connect-timeout 5 \
    --max-time 5 \
    -w "%{http_code}" \
     http://localhost:8080/actuator/health)

  echo "Attempt $i → HTTP $STATUS"

  if [ "$STATUS" = "200" ]; then
    echo "Backend is up!"
    exit 0
  fi

  sleep 5
done

echo "Backend failed to start"
exit 1

EOF
