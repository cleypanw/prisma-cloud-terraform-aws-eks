data "template_file" "ansible_inventory" {
  template  = "${file("template/data-ansible-inventory.tpl")}"
  vars      = {
    ec2instance_public_ip = aws_instance.ec2instance.public_ip
  }
}

# Upload inventory to S3
resource "aws_s3_bucket_object" "ansible_inventory" {
  bucket = local.s3_name
  key    = "ansible_inventory.ini"
  acl    = "public-read"  # or can be "public-read"
  source = "myfiles/yourfile.txt"
  etag = filemd5("myfiles/yourfile.txt")
}