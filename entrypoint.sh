#!/bin/sh

echo "set to verbose mode"
set -x 

echo "set to stop executing after error"
set -e 

echo "Starting Jekyll build"
echo "Set workspace permissions"
chmod -R a+w /github/workspace

echo "Build the Jekyll site"
jekyll build --trace
echo "Completed Jekll build"

echo "configure aws credentials"
aws configure --profile s3-sync-action <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

echo "sync to aws s3"
aws s3 sync ./_site/ \
            s3://${AWS_S3_BUCKET} \
            --delete \
            --profile s3-sync-action

echo "invalidate cloudfront"
aws cloudfront create-invalidation \
              --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} \
              --paths '/*'


