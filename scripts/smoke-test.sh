#!/bin/bash

echo "Running smoke test against $EC2_IP..."

for i in {1..20}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://$EC2_IP:8080/actuator/health)

  if [ "$STATUS" == "200" ]; then
    echo "Smoke test passed"
    exit 0
  fi

  echo "Service not ready yet..."
  sleep 5
done

echo "Smoke test failed"
docker logs ec2-user-backend-1 --tail 100

exit 1
