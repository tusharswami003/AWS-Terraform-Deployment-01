resource "aws_iam_user" "smtp" {
  name = var.smtp_user_name
  tags = var.tags
}

data "aws_iam_policy_document" "smtp_send" {
  statement {
    sid    = "SendMonitoringAlerts"
    effect = "Allow"

    actions = [
      "ses:SendRawEmail"
    ]

    resources = [
      aws_sesv2_email_identity.this.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "ses:FromAddress"
      values   = [var.sender_email]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "ses:Recipients"
      values   = [var.sender_email]
    }
  }
}

resource "aws_iam_user_policy" "smtp_send" {
  name   = "send-monitoring-alerts"
  user   = aws_iam_user.smtp.name
  policy = data.aws_iam_policy_document.smtp_send.json
}

resource "aws_iam_access_key" "smtp" {
  user = aws_iam_user.smtp.name
}