variable "cluster_name" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "admin_principal_arn" {
  description = "IAM principal that should receive EKS cluster admin access"
  type        = string
}