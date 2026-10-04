variable "vpc_id" {
  description = "ID of the VPC where the subnets will be created"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "unknown"
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tier              = string
    tags              = optional(map(string), {})
  }))
}