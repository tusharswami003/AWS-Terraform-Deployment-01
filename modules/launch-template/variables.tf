variable "name" {
  description = "Name of the launch template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for application instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for application instances"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups associated with application instances"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data used to initialize application instances"
  type        = string
  default     = null
}