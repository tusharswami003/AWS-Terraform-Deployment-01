variable "vpc_id" {
  description = "ID of the VPC where the subnets will be created"
  type        = string
}

variable "subnets" {
  description = "Configuration of subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tier              = string
  }))
}