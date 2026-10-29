#!/bin/bash
set -e
cd "$(dirname "$0")"
# Ziel wählen: DEPLOY_ENV=.deploy.env.photon-new ./deploy.sh (ohne = alter Account)
if [ -n "${DEPLOY_ENV:-}" ]; then set -a; . "./$DEPLOY_ENV"; set +a; fi

BUCKET="${WEBSITE_BUCKET:-photonestudios-website}"
CF_ID="${WEBSITE_DISTRIBUTION_ID:-E2AV0UKK8M6336}"
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
