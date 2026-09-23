variable "name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch Template version"
  type        = string
}

variable "subnet_ids" {
  description = "Private application subnets used by the ASG"
  type        = list(string)
}

variable "target_group_arns" {
  description = "ALB target groups associated with the ASG"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of application instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of application instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of application instances"
  type        = number
}