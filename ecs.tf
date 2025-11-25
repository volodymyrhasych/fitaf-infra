# ===========================
# ECS Cluster
# ===========================

resource "aws_ecs_cluster" "fitaf_cluster" {
  name = "fitaf-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}

# ===========================
# IAM role for ECS task execution
# ===========================

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "fitaf-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ===========================
# CloudWatch Logs for app
# ===========================

resource "aws_cloudwatch_log_group" "fitaf_app" {
  name              = "/ecs/fitaf-site"
  retention_in_days = 14

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}

# ===========================
# ECS Task Definition
# ===========================

resource "aws_ecs_task_definition" "fitaf_site" {
  family                   = "fitaf-site-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"   # 0.25 vCPU
  memory                   = "512"   # 0.5 GB
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "fitaf-site"
      image     = "${aws_ecr_repository.fitaf_site.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.fitaf_app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
# ===========================
# ECS Service
# ===========================

resource "aws_ecs_service" "fitaf_service" {
  name            = "fitaf-service"
  cluster         = aws_ecs_cluster.fitaf_cluster.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.fitaf_task.arn

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [aws_security_group.fitaf_ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.fitaf_target_group.arn
    container_name   = "vova-site"
    container_port   = 80
  }

  propagate_tags = "TASK_DEFINITION"

  depends_on = [
    aws_lb_listener.fitaf_http_listener
  ]

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}



  propagate_tags = "TASK_DEFINITION"
}


  depends_on = [
    aws_lb_listener.fitaf_http_listener
  ]

  tags = {
    Project   = "FitAF"
    ManagedBy = "Terraform"
  }
}
