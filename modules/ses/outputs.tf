output "email_identity_arn" {
  description = "ARN of the SES email identity"
  value       = aws_sesv2_email_identity.this.arn
}

output "smtp_user_name" {
  description = "IAM user used for Alertmanager SMTP authentication"
  value       = aws_iam_user.smtp.name
}

output "smtp_username" {
  description = "SES SMTP username"
  value       = aws_iam_access_key.smtp.id
  sensitive   = true
}

output "smtp_password" {
  description = "SES SMTP password for the configured AWS region"
  value       = aws_iam_access_key.smtp.ses_smtp_password_v4
  sensitive   = true
}