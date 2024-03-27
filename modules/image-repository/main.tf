resource "aws_ecr_repository" "main" {
  name                 = var.project_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = var.force_delete
}

resource "aws_ecr_registry_scanning_configuration" "main" {
  scan_type = "BASIC"
  rule {
    scan_frequency = "SCAN_ON_PUSH"

    repository_filter {
      filter      = "*"
      filter_type = "WILDCARD"
    }
  }
}
