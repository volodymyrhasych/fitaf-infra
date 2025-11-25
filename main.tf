terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ===========================
#  ECR Repository for FITAF site
# ===========================

resource "aws_ecr_repository" "fitaf_site" {
  name                 = "fitaf-site"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project   = "FitAF"
    Service   = "Site"
    ManagedBy = "Terraform"
  }
}
