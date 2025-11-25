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
