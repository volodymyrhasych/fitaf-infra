
# SG для ECS tasks (приймає трафік тільки від ALB)
resource "aws_security_group" "ecs_service_sg" {
  name        = "fitaf-ecs-service-sg"
  description = "Security group for FITAF ECS service"
  vpc_id      = var.vpc_id

  # Дозволяємо HTTP лише від ALB SG
  ingress {
    description     = "Allow HTTP only from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.fitaf_alb_sg.id]
  }

  # Вихідний трафік – куди завгодно (для оновлень, логів і т.д.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project   = "FitAF"
    Component = "ECS-Service"
    ManagedBy = "Terraform"
  }
}
resource "aws_security_group" "fitaf_alb_sg" {
  name        = "fitaf-alb-sg"
  description = "Security group for FITAF Application Load Balancer"
  vpc_id      = var.vpc_id

  # ALB приймає HTTP з інтернету
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Дозволяємо будь-який вихідний трафік
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
    Type      = "alb-sg"
  }
}
