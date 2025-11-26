data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "alb_logs" {

  bucket        = "fitaf-alb-logs-089623973392"
  force_destroy = true

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
    Purpose   = "alb-access-logs"
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:PutObject"
        # prefix "alb" — такий самий, як у ресурсі aws_lb.access_logs
        Resource = "${aws_s3_bucket.alb_logs.arn}/alb/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}
