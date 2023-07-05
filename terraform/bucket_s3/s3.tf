resource "aws_s3_bucket" "s3-tfstate" {
  bucket = local.s3_name
  tags = {
    Name = "s3-bucket-for-tfstate"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-tfstate" {
  bucket = aws_s3_bucket.s3-tfstate.id
  block_public_acls       = false
  block_public_policy     = false
}

resource "aws_s3_bucket_acl" "s3-tfstate" {
  depends_on = [aws_s3_bucket_ownership_controls.s3-tfstate]
  bucket = aws_s3_bucket.s3-tfstate.id
  acl    = "public-read"
}