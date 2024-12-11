output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks.arn
}

output "eks_node_group_name" {
  value = aws_eks_node_group.nodes.node_group_name
}

output "eks_oidc_issuer_url" {
  value = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "eks_oidc_issuer_url2" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
