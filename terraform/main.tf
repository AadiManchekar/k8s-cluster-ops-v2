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

  cluster_name               = var.cluster_name
  aws_region                 = var.aws_region
  eks_cluster_policy_arn     = var.eks_cluster_policy_arn
  eks_worker_node_policy_arn = var.eks_worker_node_policy_arn
  eks_cni_policy_arn         = var.eks_cni_policy_arn
}
