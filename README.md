# Action jekyll to s3 and cloudfront
This GitHub Action generate static site with jekyll, push it to aws s3 and invalidate cloudfront


## Example Workflow
```yaml
    name: Jekyl

    on: push

    jobs:
      pull-request:
        runs-on: ubuntu-latest
        steps:
        - name: Checkout
          uses: actions/checkout@v2

        - name: Jekyll build and deploy
          uses: paygoc6/action-jekyll-to-s3-cloudfront@v1.0.0
          with:
            aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
            aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
            aws_region: ${{ secrets.AWS_REGION}}
            aws_s3_bucket: 'bucket_name'
            aws_cloudfront_distribution_id: 'distribution_id'
```

