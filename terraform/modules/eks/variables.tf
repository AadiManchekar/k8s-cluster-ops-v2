# Cluster Information
variable "cluster_name" {}
variable "kubernetes_version" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "subnets" {}

# Node Group Configuration
variable "node_desired_capacity" {}
variable "node_max_capacity" {}
variable "node_min_capacity" {}
variable "node_instance_types" {}

# IAM Role
variable "cluster_iam_master_node_role_arn" {}
variable "cluster_iam_worker_node_arn" {}
