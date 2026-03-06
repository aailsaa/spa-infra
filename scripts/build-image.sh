#!/bin/bash

set -e

echo "Building Docker image..."

cd spa-app

docker build -t spa-app:latest .
