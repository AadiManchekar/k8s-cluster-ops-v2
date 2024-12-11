# EKS Control Plane Role
resource "aws_iam_role" "eks_control_plane_role" {
  name = "${var.cluster_name}-eks-control-plane-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-eks-control-plane-role"
  }
}

# Assign AmazonEKSClusterPolicy to the above created IAM role
resource "aws_iam_role_policy_attachment" "eks_control_plane_policy" {
  role       = aws_iam_role.eks_control_plane_role.name
  policy_arn = var.eks_cluster_policy_arn
}

# EKS Worker Node Role
resource "aws_iam_role" "eks_worker_node_role" {
  name = "${var.cluster_name}-eks-worker-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-eks-worker-node-role"
  }
}

# This policy already has eks-auth:AssumeRoleForPodIdentity action allowed which is useful for Pod Identity
resource "aws_iam_role_policy_attachment" "eks_worker_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = var.eks_worker_node_policy_arn
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = var.eks_cni_policy_arn
}

# Make sure to add it else worker nodes wont connect to eks control-plane
resource "aws_iam_role_policy_attachment" "_container_registry_RO_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = var.ec2_container_registry_RO_policy_arn
}