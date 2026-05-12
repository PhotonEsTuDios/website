#!/bin/bash
set -e

BUCKET="photonestudios-website"
CF_ID="E2AV0UKK8M6336"
PROFILE="${AWS_PROFILE:-photon}"

echo "Deploying to s3://$BUCKET..."
aws s3 cp index.html s3://$BUCKET/index.html --content-type "text/html" --profile $PROFILE

echo "Invalidating CloudFront..."
aws cloudfront create-invalidation \
  --distribution-id $CF_ID \
  --paths "/*" \
  --profile $PROFILE \
  --query 'Invalidation.Status' --output text

echo "Done — https://www.photonestudios.com"
