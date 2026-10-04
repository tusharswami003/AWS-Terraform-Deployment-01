variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "service_principals" {
  description = "AWS services allowed to assume this role"
  type        = list(string)
}

variable "managed_policy_arns" {
  description = "AWS managed or customer managed policies attached to the role"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline IAM policies where key is policy name and value is JSON policy"
  type        = map(string)
  default     = {}
}

variable "create_instance_profile" {
  description = "Whether to create an EC2 instance profile for this role"
  type        = bool
  default     = false
}

variable "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to IAM resources"
  type        = map(string)
  default     = {}
}

variable "assume_role_policy_json" {
  description = "Optional custom IAM trust policy JSON"
  type        = string
  default     = null
}