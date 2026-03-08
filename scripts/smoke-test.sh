#!/bin/bash

echo "Running smoke test against $EC2_IP..."

MAX_ATTEMPTS=40
SLEEP_SECONDS=5

for i in $(seq 1 $MAX_ATTEMPTS); do
  echo "Attempt $i of $MAX_ATTEMPTS..."

  STATUS=$(curl --max-time 5 -s -o /dev/null -w "%{http_code}" http://$EC2_IP:8080/actuator/health)

  echo "HTTP status: $STATUS"

  if [ "$STATUS" = "200" ]; then
    echo "Smoke test passed ✅"
    exit 0
  fi

  echo "Service not ready yet, waiting ${SLEEP_SECONDS}s..."
  sleep $SLEEP_SECONDS
done

echo "Smoke test failed ❌ after $MAX_ATTEMPTS attempts"

echo "Fetching backend logs for debugging..."
ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP \
"sudo docker logs ec2-user-backend-1 --tail 100"

exit 1
