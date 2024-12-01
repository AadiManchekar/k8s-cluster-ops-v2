output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = var.cluster_name
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}
