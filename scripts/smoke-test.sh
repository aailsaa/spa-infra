#!/bin/bash

echo "Starting containers..."

docker run -d -p 8080:8080 spa-backend
docker run -d -p 3000:3000 spa-frontend

echo "Waiting for backend to start..."

for i in {1..20}; do
  if curl -s http://localhost:8080 > /dev/null; then
    echo "Backend is up!"
    break
  fi
  echo "Waiting..."
  sleep 5
done

echo "Running smoke test..."

curl http://localhost:8080
