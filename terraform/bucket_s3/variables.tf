variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "name_prefix" {
  description = "Objects name prefix to use for deployment"
  type        = string
  default     = "eks"
}

variable "name_prefix" {
  description = "GitHub actor who triggered the creation"
  type        = string
  default     = "actor"
}