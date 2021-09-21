#!/bin/bash

# Delete any of the running containers
docker rm -f $(docker ps -qa)
# Create Network
docker network create new-network
# Build the flask app Image 
docker build -t duo-task-flask:latest .
# Run the flask app container in the network
docker run -d --network new-network --name flask-app duo-task-flask:latest
# Run NGNIX  container in the network
docker run -d --network new-network --name nginx --mount type=bind,source=$(pwd)/nginx.conf,target=/etc/nginx/nginx.conf -p 80:80 --name nginx nginx:alpine