data "aws_s3_bucket_object" "ansible_inventory" {
    bucket      = local.s3_name
    key         = "ansible_inventory.ini"
}

data "template_file" "ansible_inventory" {}
