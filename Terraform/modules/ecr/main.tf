###############################################################################
# Frontend Repository
###############################################################################

resource "aws_ecr_repository" "frontend" {

  name = "${var.project_name}-${var.environment}-frontend"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Name        = "${var.project_name}-frontend"
    Environment = var.environment
    Terraform   = "true"
  }
}

###############################################################################
# Backend Repository
###############################################################################

resource "aws_ecr_repository" "backend" {

  name = "${var.project_name}-${var.environment}-backend"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Name        = "${var.project_name}-backend"
    Environment = var.environment
    Terraform   = "true"
  }
}

###############################################################################
# MongoDB Repository
###############################################################################

resource "aws_ecr_repository" "mongodb" {

  name = "${var.project_name}-${var.environment}-mongodb"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Name        = "${var.project_name}-mongodb"
    Environment = var.environment
    Terraform   = "true"
  }
}