resource "aws_s3_bucket" "s3-tfstate" {
  bucket = local.s3_name
  tags = {
    Name      = "s3-bucket-for-tfstate"
    yor_trace = "c470c69a-513e-4784-96fd-af23e652cc75"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-tfstate" {
  bucket              = aws_s3_bucket.s3-tfstate.id
  block_public_acls   = false
  block_public_policy = false
}
