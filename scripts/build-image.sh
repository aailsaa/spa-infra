#!/bin/bash
set -e

echo "Building backend image..."
docker build -t spa-backend ./spa-app/appointment-scheduler

echo "Building frontend image..."
docker build -t spa-frontend ./spa-app/appointment-scheduler-frontend
