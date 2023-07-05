data "template_file" "ansible_inventory" {
  template  = "${file("${path.module}/template/ansible-inventory.tpl")}"
  vars      = {
    ec2instance_public_ip = aws_instance.ec2instance.public_ip
  }
}

# Upload inventory to S3
resource "aws_s3_object" "ansible_inventory" {
  bucket  = local.s3_name
  key     = "ansible_inventory.ini"
  acl     = "public-read"  # or can be "public-read"
  content = data.template_file.ansible_inventory.rendered
}