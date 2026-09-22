variable "name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets where the ALB will be deployed"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups associated with the ALB"
  type        = list(string)
}

variable "target_instance_ids" {
  description = "Map of target names to EC2 instance IDs"
  type        = map(string)
}

variable "target_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Health check path used by the target group"
  type        = string
  default     = "/"
}