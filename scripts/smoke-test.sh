#!/bin/bash

set -e

echo "Running smoke tests..."

docker run -d -p 5000:5000 --name test-container spa-app:latest

sleep 10

curl http://localhost:5000 || exit 1

docker stop test-container
docker rm test-container

echo "Smoke test passed!"
