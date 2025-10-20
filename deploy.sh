#!/bin/bash
# Simple deployment script for EC2 (placeholder IPs)
USER="ubuntu"
HOST="3.109.186.0"
IMAGE="vikicr7/joke:latest"

echo "🚀 Starting deployment on $HOST as $USER ..."

# stop old container if running
if ssh -o StrictHostKeyChecking=no $USER@$HOST "docker ps -q --filter 'name=joke' | grep -q ."; then
  ssh -o StrictHostKeyChecking=no $USER@$HOST "docker stop joke && docker rm -f joke" || true
fi

# pull latest image
ssh -o StrictHostKeyChecking=no $USER@$HOST "docker pull $IMAGE"

# run new container
ssh -o StrictHostKeyChecking=no $USER@$HOST "docker run -d --name joke -p 8080:8080 $IMAGE"

echo "✅ Deployment script finished."
