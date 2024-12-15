resource "aws_iam_role" "cluster_autoscaler" {
  name = "${var.cluster_name}-cluster-autoscaler"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name   = "${var.cluster_name}-cluster-autoscaler-policy"
  policy = file("${path.module}/cluster_autoscaler_policy.json")
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_attachment" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}

resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name    = var.cluster_name
  namespace       = var.cluster_autoscaler_NS
  service_account = var.cluster_autoscaler_SA
  role_arn        = aws_iam_role.cluster_autoscaler.arn
}


resource "helm_release" "cluster_autoscaler" {
  name       = "autoscaler"
  chart      = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  namespace  = var.cluster_autoscaler_NS
  version    = var.cluster_autoscaler_version

  values = [
    templatefile("${path.module}/values/cluster_autoscaler_values.yaml.tmpl", {
      service_account = var.cluster_autoscaler_SA,
      cluster_name    = var.cluster_name,
      aws_region      = var.aws_region
    })
  ]


  depends_on = [aws_iam_role_policy_attachment.cluster_autoscaler_attachment, aws_eks_pod_identity_association.cluster_autoscaler]
}
