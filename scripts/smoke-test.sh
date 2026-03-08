#!/bin/bash

echo "Running smoke test against $EC2_IP..."

MAX_ATTEMPTS=40
SLEEP_SECONDS=5
URL="http://$EC2_IP:8080/actuator/health"

for i in $(seq 1 $MAX_ATTEMPTS); do
  echo "Attempt $i/$MAX_ATTEMPTS"

  STATUS=$(curl --max-time 5 -s -o response.txt -w "%{http_code}" $URL)

  echo "HTTP status: $STATUS"

  if [ "$STATUS" = "200" ]; then
    echo "Smoke test passed ✅"
    cat response.txt
    exit 0
  fi

  echo "Service not ready yet..."
  sleep $SLEEP_SECONDS
done

echo "Smoke test failed after $MAX_ATTEMPTS attempts"
echo "Last response body:"
cat response.txt

exit 1
