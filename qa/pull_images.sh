#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 343830488876.dkr.ecr.us-east-1.amazonaws.com

export FRONTEND_LATEST_LOCAL=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -E '^.*:frontend_' | awk -F: '{print $2}' | sort -V | head -n 1)

echo "FRONTEND_LATEST_LOCAL=$FRONTEND_LATEST_LOCAL"

export BACKEND_LATEST_LOCAL=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -E '^.*:backend_' | awk -F: '{print $2}' | sort -V | head -n 1)

echo "BACKEND_LATEST_LOCAL=$BACKEND_LATEST_LOCAL"

export LATEST_BACKEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_2 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'backend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_BACKEND_TAG=$LATEST_BACKEND_TAG"

# shellcheck disable=SC2155
export LATEST_FRONTEND_TAG=$(aws ecr describe-images --repository-name midterm/ecr_2 \
    --query "reverse(sort_by(imageDetails[?starts_with(imageTags[0], 'frontend_')], &imagePushedAt))[0].imageTags[0]" \
    --output text)

echo "LATEST_FRONTEND_TAG=$LATEST_FRONTEND_TAG"

if [[ "$LATEST_FRONTEND_TAG" != "$FRONTEND_LATEST_LOCAL" ]]; then
    docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG
    docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:frontend_latest
    # Command A
else
    echo "Images are already updated"
fi
if [[ "$LATEST_BACKEND_TAG" != "$BACKEND_LATEST_LOCAL" ]]; then
    docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG
    docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:backend_latest
    # Command A
else
    echo "Images are already updated"
fi

#docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG

#docker pull 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG

#docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_BACKEND_TAG \
  #343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:backend_latest

#docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$LATEST_FRONTEND_TAG \
#  343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:frontend_latest