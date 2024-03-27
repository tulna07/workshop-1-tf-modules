output "repository_name" {
  description = "The name of the repository"
  value       = var.project_name
}

output "repository_url" {
  description = "The url of the repository"
  value       = aws_ecr_repository.main.repository_url
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.main.registry_id
}

output "repository_arn" {
  description = "The arn of the repo"
  value       = aws_ecr_repository.main.arn
}
