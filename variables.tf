variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}
variable "vpc_id" {
  type        = string
  description = "The VPC ID where ALB and ECS run"
}
variable "alb_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}
# ===========================
# ALB Listener (HTTP)
# ===========================

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}
