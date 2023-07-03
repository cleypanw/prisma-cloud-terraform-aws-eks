module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = false

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
