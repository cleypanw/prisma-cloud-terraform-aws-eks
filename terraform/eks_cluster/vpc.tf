module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

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