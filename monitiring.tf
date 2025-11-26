# ===========================
# SNS topic для продакшн-алертів
# ===========================

resource "aws_sns_topic" "fitaf_alerts" {
  name = "fitaf-prod-alerts"

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
    Type      = "alerts"
  }
}

# Підписка на email
resource "aws_sns_topic_subscription" "fitaf_alerts_email" {
  topic_arn = aws_sns_topic.fitaf_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
