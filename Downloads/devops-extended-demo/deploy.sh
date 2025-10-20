#!/bin/bash
# Simple deployment script for EC2 (placeholder IPs)
USER="ubuntu"
HOST="<EC2-IP>"
IMAGE="vikicr7/devops-extended-demo:latest"

echo "🚀 Starting deployment on $HOST as $USER ..."

# stop old container if running
if ssh -o StrictHostKeyChecking=no $USER@$HOST "docker ps -q --filter 'name=devops-extended-demo' | grep -q ."; then
  ssh -o StrictHostKeyChecking=no $USER@$HOST "docker stop devops-extended-demo && docker rm -f devops-extended-demo" || true
fi

# pull latest image
ssh -o StrictHostKeyChecking=no $USER@$HOST "docker pull $IMAGE"

# run new container
ssh -o StrictHostKeyChecking=no $USER@$HOST "docker run -d --name devops-extended-demo -p 8080:8080 $IMAGE"

echo "✅ Deployment script finished."
