

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$BACKEND_TIMESTAMP 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$BACKEND_TIMESTAMP

docker tag 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_1:$FRONTEND_TIMESTAMP 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$FRONTEND_TIMESTAMP

docker push 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$BACKEND_TIMESTAMP

docker push 343830488876.dkr.ecr.us-east-1.amazonaws.com/midterm/ecr_2:$FRONTEND_TIMESTAMP