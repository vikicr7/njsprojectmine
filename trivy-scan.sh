#!/bin/bash
IMAGE_NAME="joke:latest"
echo "🔍 Running Trivy scan for image: $IMAGE_NAME ..."
trivy image --exit-code 0 --severity CRITICAL,HIGH $IMAGE_NAME
RC=$?
if [ $RC -eq 0 ]; then
  echo "✅ Trivy scan completed (no CRITICAL/HIGH findings)."
else
  echo "❌ Trivy scan found CRITICAL/HIGH issues. Return code: $RC"
  exit $RC
fi
