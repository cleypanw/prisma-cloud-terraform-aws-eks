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

# Configure public key to enable ssh access
variable "public_ssh_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzLnC7bnTFB8bEhWCUHh8B418rFwla7iJYclITd/59ZpZft3EdgeW9y/uLUfMH8f5P7be5j0NYLfD6jpou0VHdSkLymNJxaQDuvZBapW4jQI4luqRmN4xFeDIT+0BqT3sJotqU/n41NOGclEv/OMv6msulnC8A7wOBkrMJPzgNgs4a0+a8f/Slp9aAHpgKiWREwtFJDczFM0wUkQldEALg3QQt7qmpZgVx3KQi6u5YI0EqdjfMSP+qnY7Lk9yn2gQPPAR+NGgqz9d7bpsgqhggpw8k+Yw75bROdnk90Cc07zIg+lbBsyBoVNA+mRtejTC1IS9F1Pa+WdVtD3xpes7y0RCx6pxkTfLjB725FRs7EQ31lr031lC4fHB/bwfbU7QsCdHqrOJosKlNwG49qLc57LPS6qUKcJSCAjj3MZjTDNDuL8cxbdOy60fgI9n0YsDIY+5/YBItfsQStdJFzhLjsYN1oJx3HYF5ew+gngx8CzEGJ2s/fSpwducGMlFUcEjPAlVh94DpYubj06opOW1SM3w8U9BvUwC87uNhkI5Pn51kh7U2bOMJmxSnkl4RHmC6qj08HjCBQYaqzGEXstaoIExykTfHm3zFv4KiTMfH6fN5eaRpwvL3AYzAyAA6FbpXM2W8x35PM1lWgarrybg6iC3zYWDkjXlscD1Iu1uPYw== cley"  # Change me
}