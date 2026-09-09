variable "vpc_id" {
  description = "ID of the VPC where the subnets will be created"
  type        = string
}

variable "subnets" {
  description = "Map of subnet names to their CIDR blocks"
  type        = map(string)
}