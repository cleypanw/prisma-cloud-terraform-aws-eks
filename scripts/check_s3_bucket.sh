#!/bin/bash

bucket_name=$1-s3-tfstate

# Check if the bucket exists
if aws s3api head-bucket --bucket "$bucket_name" 2>/dev/null; then
    echo "The bucket '$bucket_name' exists."
    echo "No need to create it, it will be used to store infrastructure tfstate which will be created later"
else
    echo "The bucket '$bucket_name' does not exist."
    echo "'$bucket_name' Bucket S3 creation in progress..."
    terraform -chdir="../terraform/bucket_s3" init
    terraform -chdir="../terraform/bucket_s3" apply -var="name_prefix=$1" -auto-approve
fi
