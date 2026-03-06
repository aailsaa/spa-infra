#!/bin/bash
set -e

docker run -d -p 8080:8080 --name backend spa-backend
docker run -d -p 3000:3000 --name frontend spa-frontend

sleep 20

curl http://localhost:8080 || exit 1
curl http://localhost:3000 || exit 1

docker stop backend frontend
docker rm backend frontend
