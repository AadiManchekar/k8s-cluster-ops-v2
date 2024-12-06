output "eks_control_plane_role_name" {
  description = "Name of the IAM role for EKS control plane"
  value       = aws_iam_role.eks_control_plane_role.name
}

output "eks_control_plane_role_arn" {
  description = "ARN of the IAM role for EKS control plane"
  value       = aws_iam_role.eks_control_plane_role.arn
}

output "eks_worker_node_role_name" {
  description = "Name of the IAM role for EKS worker nodes"
  value       = aws_iam_role.eks_worker_node_role.name
}

output "eks_worker_node_role_arn" {
  description = "ARN of the IAM role for EKS worker nodes"
  value       = aws_iam_role.eks_worker_node_role.arn
}
