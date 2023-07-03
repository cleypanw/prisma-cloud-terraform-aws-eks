
output "region" {
  description = "AWS region"
  value       = var.region
}


output "bucket_name" {
  description = "s3 Bucket Name"
  value = resource.aws_s3_bucket.s3-tfstate.bucket
}
