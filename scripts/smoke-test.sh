#!/bin/bash

echo "Running smoke test against EC2..."

for i in {1..20}; do
  if curl -s http://$EC2_IP:8080 > /dev/null; then
    echo "Backend is up!"
    exit 0
  fi

  echo "Waiting..."
  sleep 5
done

echo "Smoke test failed"
exit 1
