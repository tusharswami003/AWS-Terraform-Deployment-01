variable "environment" {
  description = "Environment name such as dev, test, or prod"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}