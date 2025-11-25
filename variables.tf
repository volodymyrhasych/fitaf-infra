variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}
variable "vpc_id" {
  type        = string
  description = "The VPC ID where ALB and ECS run"
}
