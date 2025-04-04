#!/bin/bash

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ${USER}

mkdir -p "$DOCKER_CONFIG"/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.33.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x "$DOCKER_CONFIG"/cli-plugins/docker-compose