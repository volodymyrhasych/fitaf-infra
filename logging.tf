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
        Sid    = "AWSALBWrite"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::127311923021:root" # ELB account ID для us-east-1
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}
