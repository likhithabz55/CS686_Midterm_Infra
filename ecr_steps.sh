#!/bin/bash

aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 343830488876.dkr.ecr.us-east-1.amazonaws.com

export LATEST_BACKEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_1 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'backend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_BACKEND_TAG=$LATEST_BACKEND_TAG" >> $GITHUB_ENV

export LATEST_FRONTEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_1 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'frontend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_FRONTEND_TAG=$LATEST_FRONTEND_TAG" >> $GITHUB_ENV

sudo docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$LATEST_BACKEND_TAG

sudo docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$LATEST_FRONTEND_TAG

sudo docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$LATEST_BACKEND_TAG \
  343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:backend_latest

sudo docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$LATEST_FRONTEND_TAG \
  343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:frontend_latest

mv ./docker-compose.ec2.yml ./docker-compose.yml
export DOCKER_CONFIG=/home/ec2-user/.docker
sudo docker compose up -d
