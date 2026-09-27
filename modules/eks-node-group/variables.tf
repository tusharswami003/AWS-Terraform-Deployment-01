variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "EC2 instance types used by the node group"
  type        = list(string)
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired worker node count"
  type        = number
}

variable "min_size" {
  description = "Minimum worker node count"
  type        = number
}

variable "max_size" {
  description = "Maximum worker node count"
  type        = number
}

variable "tags" {
  description = "Tags applied to node group resources"
  type        = map(string)
  default     = {}
}