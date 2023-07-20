# Generate file from template
data "template_file" "ansible_inventory" {
  template  = "${file("${path.module}/template/ansible-inventory.tpl")}"
  vars      = {
    ec2instance_public_ip = aws_instance.ec2instance.public_ip
  }
}

data "template_file" "cluster_name" {
  template  = "${file("${path.module}/template/cluster-name.tpl")}"
  vars      = {
    cluster_name = module.eks.cluster_name
  }
}

# Upload objects (inventory + cluster) to S3
resource "aws_s3_object" "ansible_inventory" {
  bucket  = local.s3_name
  key     = "ansible_inventory.ini"
  content = data.template_file.ansible_inventory.rendered
}

resource "aws_s3_object" "cluster_name" {
  bucket  = local.s3_name
  key     = "cluster_name.txt"
  content = data.template_file.cluster_name.rendered
}