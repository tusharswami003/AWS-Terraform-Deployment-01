variable "aws_region" {
  description = "AWS region where the dev infrastructure will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the dev VPC"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration for the dev environment"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tier              = string
  }))
}

variable "ec2_ami_id" {
  description = "AMI ID for the dev EC2 instance"
  type        = string
}

variable "ec2_key_name" {
  description = "EC2 key pair name for the dev instance"
  type        = string
  default     = null
}

variable "app_servers" {
  description = "Application servers to deploy"

  type = map(object({
    instance_type = string
    subnet_name   = string
  }))
}

variable "app_port" {
  description = "Port used by the application servers"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "ALB health check path"
  type        = string
  default     = "/"
}

variable "db_servers" {
  description = "Application servers to deploy"

  type = map(object({
    subnet_name = string
  }))
}

variable "db_instance_type" {
  description = "Instance type for DB EC2 instance"
  type        = string
}