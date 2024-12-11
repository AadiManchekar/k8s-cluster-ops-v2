variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "mocha"
}

variable "kubernetes_version" {
  description = "EKS cluster k8s version"
  type        = string
  default     = "1.29"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "availability_zone_1" {
  description = "First availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Second availability zone"
  type        = string
  default     = "us-east-1b"
}

variable "eks_cluster_policy_arn" {
  description = "Amazon's AmazonEKSClusterPolicy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

variable "eks_worker_node_policy_arn" {
  description = "Amazon's AmazonEKSWorkerNodePolicy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "eks_cni_policy_arn" {
  description = "Amazon's AmazonEKS_CNI_Policy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "ec2_container_registry_RO_policy_arn" {
  description = "Amazon's AmazonEC2ContainerRegistryReadOnly Policy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "node_desired_capacity" {
  description = "desired nodes in eks cluster"
  default     = 2
}

variable "node_max_capacity" {
  description = "max nodes in eks cluster"
  default     = 3
}

variable "node_min_capacity" {
  description = "min nodes in eks cluster"
  default     = 1
}

variable "node_instance_types" {
  default = ["t3.large"]
}
