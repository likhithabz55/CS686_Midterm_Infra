export FRONTEND_TIMESTAMP=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -E '^.*:frontend_' | awk -F: '{print $2}' | sort -V | head -n 1)

export BACKEND_TIMESTAMP=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -E '^.*:backend_' | awk -F: '{print $2}' | sort -V | head -n 1)

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$BACKEND_TIMESTAMP 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$BACKEND_TIMESTAMP

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$FRONTEND_TIMESTAMP 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$FRONTEND_TIMESTAMP

docker push 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$BACKEND_TIMESTAMP

docker push 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$FRONTEND_TIMESTAMP