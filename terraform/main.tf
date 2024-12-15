terraform {
  backend "s3" {
    bucket  = "mocha-eks-state" # S3 bucket name
    key     = "terraform/state" # Path to store the state
    region  = "us-east-1"       # AWS region
    profile = "mocha"           # AWS CLI profile
  }
}

module "vpc" {
  source = "./modules/vpc"

  cluster_name          = var.cluster_name
  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
}

module "iam" {
  source = "./modules/iam"

  cluster_name                         = var.cluster_name
  aws_region                           = var.aws_region
  eks_cluster_policy_arn               = var.eks_cluster_policy_arn
  eks_worker_node_policy_arn           = var.eks_worker_node_policy_arn
  eks_cni_policy_arn                   = var.eks_cni_policy_arn
  ec2_container_registry_RO_policy_arn = var.ec2_container_registry_RO_policy_arn
}

module "eks" {
  source = "./modules/eks"

  cluster_name                     = var.cluster_name
  kubernetes_version               = var.kubernetes_version
  aws_region                       = var.aws_region
  vpc_id                           = module.vpc.vpc_id
  subnets                          = module.vpc.private_subnets
  node_desired_capacity            = var.node_desired_capacity
  node_max_capacity                = var.node_max_capacity
  node_min_capacity                = var.node_min_capacity
  node_instance_types              = var.node_instance_types
  cluster_iam_master_node_role_arn = module.iam.eks_control_plane_role_arn
  cluster_iam_worker_node_arn      = module.iam.eks_worker_node_role_arn
}

module "metrics_server" {
  source = "./modules/helm/metrics-server"

  metrics_chart_name      = var.metrics_chart_name
  metrics_release_version = var.metrics_release_version
  metrics_namespace       = var.metrics_namespace
}

module "cluster_autoscaler" {
  source = "./modules/helm/cluster-autoscaler"

  cluster_name               = var.cluster_name
  aws_region                 = var.aws_region
  cluster_autoscaler_SA      = var.cluster_autoscaler_SA
  cluster_autoscaler_NS      = var.cluster_autoscaler_NS
  cluster_autoscaler_version = var.cluster_autoscaler_version
}
