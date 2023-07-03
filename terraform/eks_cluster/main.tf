# Kubernetes provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}

locals {
  cluster_name = "${var.name_prefix}-eks-${random_string.suffix.result}"
  s3_name      = "${var.name_prefix}-s3"
  vpc_name     = "${var.name_prefix}-vpc"
}




