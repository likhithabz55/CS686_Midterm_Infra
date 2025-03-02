#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 343830488876.dkr.ecr.us-east-1.amazonaws.com

export LATEST_BACKEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_2 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'backend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_BACKEND_TAG=$LATEST_BACKEND_TAG"

# shellcheck disable=SC2155
export LATEST_FRONTEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_2 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'frontend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_FRONTEND_TAG=$LATEST_FRONTEND_TAG"

docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG

docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG \
  343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:backend_latest

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG \
  343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:frontend_latest