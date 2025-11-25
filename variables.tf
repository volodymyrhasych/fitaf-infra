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

resource "aws_lb_listener" "fitaf_http_listener" {
  load_balancer_arn = aws_lb.fitaf_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fitaf_tg.arn
  }
}
