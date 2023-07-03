terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
    }
  }

  required_version = "~> 1.3"

  data "aws_s3_bucket" "s3-tfstate" {
    bucket = local.s3_name
  }

  backend "s3" {
    bucket = data.aws_s3_bucket.s3-tfstate.bucket
    key    = "${local.cluster_name}.tfstate"
    region = var.region
  }
}

