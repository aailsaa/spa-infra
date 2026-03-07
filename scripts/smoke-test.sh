#!/bin/bash

echo "Running smoke test on EC2..."

ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP << EOF

echo "Waiting for backend startup..."

for i in {1..40}; do
  STATUS=\$(curl -s -o /dev/null \
    --connect-timeout 5 \
    --max-time 5 \
    -w "%{http_code}" \
    http://localhost:8080/actuator/health)

  echo "Attempt \$i → HTTP \$STATUS"

  if [ "\$STATUS" = "200" ]; then
    echo "Backend is UP"
    exit 0
  fi

  sleep 5
done

echo "Backend failed to start"
docker logs ec2-user-backend-1 --tail 100

exit 1
EOF
