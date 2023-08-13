# Action jekyll to s3 and cloudfront
This GitHub Action generate static site with jekyll, push it to aws s3 and invalidate cloudfront

Note that

* `AWS_S3_BUCKET` refers to the **name** of the bucket (not the full ARN)
* `AWS_CLOUDFRONT_DISTRIBUTION_ID` is just the **ID** of the distribution (not the full ARN)

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
          env: 
            AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
            AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
            AWS_REGION: ${{ secrets.AWS_REGION}}
          with:
            AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET}}
            AWS_CLOUDFRONT_DISTRIBUTION_ID: ${{ secrets.AWS_CLOUDFRONT_DISTRIBUTION_ID }}
```

