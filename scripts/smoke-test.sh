#!/bin/bash
set -e

echo "Starting application with docker compose..."

cd spa-app

docker compose up -d --build

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

echo "Containers running:"
docker ps

echo "Backend logs:"
docker compose logs backend

docker compose down
