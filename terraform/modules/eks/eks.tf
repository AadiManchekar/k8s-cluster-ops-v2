resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = var.cluster_iam_master_node_role_arn

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    # Passing on private subnets
    subnet_ids = var.subnets
  }
}


# Managed Node Group
resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  version         = var.kubernetes_version
  node_group_name = "${var.cluster_name}-${var.aws_region}-node-group"
  node_role_arn   = var.cluster_iam_worker_node_arn

  subnet_ids = var.subnets

  # Other option is SPOT, these instances are cheap but AWS can take it anytime
  capacity_type  = "ON_DEMAND"
  instance_types = var.node_instance_types


  scaling_config {
    desired_size = var.node_desired_capacity
    max_size     = var.node_max_capacity
    min_size     = var.node_min_capacity
  }

  update_config {
    max_unavailable = 1
  }

  # later we can have few SPOT nodes and label them general-spot 
  labels = {
    role = "general-on-demand"
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [aws_eks_cluster.eks] # Ensure cluster is created first
}
