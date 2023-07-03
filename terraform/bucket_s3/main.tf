provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  s3_name     = "${var.name_prefix}-s3-tfstate"
}




