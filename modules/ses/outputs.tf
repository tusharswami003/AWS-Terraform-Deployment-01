output "email_identity_arn" {
  description = "ARN of the SES email identity"
  value       = aws_sesv2_email_identity.this.arn
}

output "smtp_user_name" {
  description = "IAM user used for Alertmanager SMTP authentication"
  value       = aws_iam_user.smtp.name
}