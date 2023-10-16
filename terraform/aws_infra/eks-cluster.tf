module "eks" {
  #source  = "terraform-aws-modules/eks/aws"
  #version = "19.0.4"
  # CKV_TF_1 use Terraform module sources do not use a git url with a commit hash revision 
  # https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-code-security-policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=51cc6bec880ac8dc361b60a4b05d5f2bcd98eb6a" # CKV_TF_1

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                                = module.vpc.vpc_id
  subnet_ids                            = module.vpc.private_subnets
  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = false
  # Add ec2-bastion security group to allow to connect to the cluster control plane
  cluster_additional_security_group_ids = ["${aws_security_group.ec2-bastion.id}"]

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name           = "eks-node-group-1"
      instance_types = ["${var.worker_nodes_type}"]
      min_size       = 1
      max_size       = 5
      desired_size   = var.worker_nodes_desired_size
      metadata_options = {
        http_endpoint          = "enabled"
        http_tokens            = "required"
        instance_metadata_tags = "enabled"
      }
    }

    #    two = {
    #      name = "eks-node-group-2"
    #
    #      instance_types = ["t3.medium"]
    #
    #      min_size     = 1
    #      max_size     = 3
    #      desired_size = 2
    #      metadata_options = {
    #       http_endpoint          = "enabled"
    #       http_tokens            = "required"
    #       instance_metadata_tags = "enabled"
    #      }
    #    }
  }
}
