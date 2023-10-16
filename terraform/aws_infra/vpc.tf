module "vpc" {

  #source  = "terraform-aws-modules/vpc/aws"
  #version = "3.14.2"
  # CKV_TF_1 use Terraform module sources do not use a git url with a commit hash revision 
  # https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-code-security-policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=bf9a89bf447a9c866dc0d30486aec5a24dbe2631" #CKV_TF_1

  name = local.vpc_name

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

#resource "aws_internet_gateway" "internet_gw" {
# vpc_id = module.vpc.vpc_id
# 
# tags = {
#   Name = "Project VPC IG"
# }
#}

#resource "aws_route_table" "internet_route_table" {
# vpc_id = module.vpc.vpc_id
# 
# route {
#   cidr_block = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.internet_gw.id
# }
# 
# tags = {
#   Name = "2nd Route Table - Internet Route Table"
# }
#}