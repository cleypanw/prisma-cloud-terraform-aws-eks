module "eks" {
  #source  = "terraform-aws-modules/eks/aws"  # Uncomment to Generate CKV_TF_1 https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision
  #version = "19.21.0"                        # Uncomment to Generate CKV_TF_1
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=2cb1fac31b0fc2dd6a236b0c0678df75819c5a3b" # commit hash of version 19.21.0

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

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
