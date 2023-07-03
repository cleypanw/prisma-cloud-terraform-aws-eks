variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "name_prefix" {
  description = "Objects name prefix to use for deployment"
  type        = string
  default     = "cley"
}

variable "worker_nodes_desired_size" {
  description = "number of worker nodes in the cluster"
  type        = number
  default     = "3"
}

variable "worker_nodes_type" {
  description = "EC2 type of worker nodes in the cluster (default t3.medium)"
  type        = string
  default     = "t3.medium"
}

