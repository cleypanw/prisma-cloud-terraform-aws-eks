# Kubernetes provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

# Retrieve S3 Bucket
data "aws_s3_bucket" "s3-tfstate" {
  bucket = local.s3_name
}

# Ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Generate Random 3 chars
#resource "random_string" "suffix" {
#  length  = 3
#  special = false
#  upper   = false
#}

# Define local var that will be use by TF
locals {
  cluster_name      = "${var.name_prefix}-eks-${var.name_suffix}"
  vpc_name          = "${var.name_prefix}-vpc-${var.name_suffix}"
  s3_name           = "${var.name_prefix}-s3-tfstate-${var.name_suffix}"
  ec2_bastion_name  = "${var.name_prefix}-ec2-bastion-${var.name_suffix}"
  sshkey_name       = "${var.name_prefix}-sshkey-${var.name_suffix}"
  sg_name           = "${var.name_prefix}-sg-${var.name_suffix}"
  ecr_name          = "${var.name_prefix}-ecr-${var.name_suffix}"
}




