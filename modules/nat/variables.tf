variable "public_subnet_id" {
  description = "Public subnet where the NAT Gateway will be created"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}