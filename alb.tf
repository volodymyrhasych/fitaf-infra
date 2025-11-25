# ===========================
# Target Group for ECS Service
# ===========================

resource "aws_lb_target_group" "fitaf_tg" {
  name        = "fitaf-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
# ===========================
# Application Load Balancer
# ===========================

resource "aws_lb" "fitaf_alb" {
  name               = "fitaf-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
