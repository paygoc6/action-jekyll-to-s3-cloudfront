#!/bin/sh

echo "set to verbose mode"
set -x 

echo "set to stop executing after error"
set -e 

echo "Start Jekyll build"
echo "Set workspace permissions"
chmod -R a+w /github/workspace

echo "Build the Jekyll site"
jekyll build --trace
echo "Completed Jekll build"

echo "Configure aws credentials"
aws configure --profile s3-sync-action <<-EOF > /dev/null 2>&1
$AWS_ACCESS_KEY_ID
$AWS_SECRET_ACCESS_KEY
$AWS_REGION
text
EOF

echo "Publishing ._site/ to S3 bucket named ${AWS_S3_BUCKET}"
aws s3 sync _site/ "s3://${AWS_S3_BUCKET}" --delete --profile s3-sync-action

echo "Invalidate cloudfront"
aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths '/*'

echo "Success Finished"              


