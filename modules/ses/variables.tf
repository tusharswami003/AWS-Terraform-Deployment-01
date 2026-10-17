variable "sender_email" {
  description = "Email address verified in SES for monitoring notifications"
  type        = string
}

variable "tags" {
  description = "Tags applied to SES resources"
  type        = map(string)
  default     = {}
}

variable "smtp_user_name" {
  description = "Dedicated IAM user for Alertmanager SMTP authentication"
  type        = string
}