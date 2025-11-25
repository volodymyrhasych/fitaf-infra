terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "fitaf-terraform-state-089623973392"  # <-- сюди постав ТВОЮ назву бакету
    key            = "global/fitaf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

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
