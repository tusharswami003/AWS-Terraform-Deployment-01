variable "aws_region" {
  description = "AWS region used for the test environment"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for the test VPC"
  type        = string
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tier              = string
    tags              = optional(map(string), {})
  }))
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version used by EKS"
  type        = string
}

variable "eks_admin_principal_arn" {
  description = "IAM principal that should receive EKS cluster admin access"
  type        = string
}

variable "eks_node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
}

variable "eks_instance_types" {
  description = "EC2 instance types used by EKS worker nodes"
  type        = list(string)
}

variable "eks_capacity_type" {
  description = "EKS node capacity type"
  type        = string

  validation {
    condition = contains(
      ["ON_DEMAND", "SPOT"],
      var.eks_capacity_type
    )

    error_message = "eks_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "eks_desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
}

variable "eks_min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
}

variable "eks_max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
}