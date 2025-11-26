output "ecr_url" {
  value = aws_ecr_repository.fitaf_site.repository_url
}
# ===========================
# Core outputs for FitAF infra
# ===========================

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.fitaf_alb.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.fitaf_cluster.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.fitaf_service.name
}

output "ecr_repository_url" {
  description = "ECR repo URL for site image"
  value       = aws_ecr_repository.fitaf_site.repository_url
}
