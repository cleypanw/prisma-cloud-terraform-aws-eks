output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "ec2instance_ip" {
  value = aws_instance.ec2instance.public_ip
}

output "ec2instance_dns" {
  value = aws_instance.ec2instance.public_dns
}

output "ecr_registry_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}