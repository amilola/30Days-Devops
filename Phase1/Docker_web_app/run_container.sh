#!/bin/bash
#Builds and runs the Flask Docker Container

IMAGE_NAME="flask-docker-app"

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

echo "Running Container ..."
docker run -d -p 5000:5000 $IMAGE_NAME

echo "App running on http://localhost:5000"

echo "Just Checking stats...."

docker ps
docker images