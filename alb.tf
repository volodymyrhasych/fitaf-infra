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
  security_groups = [aws_security_group.fitaf_alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
# ===========================
# ALB Listener (HTTP :80)
# ===========================

resource "aws_lb_listener" "fitaf_http_listener" {
  load_balancer_arn = aws_lb.fitaf_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fitaf_tg.arn
  }

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
