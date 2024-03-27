output "arn" {
  description = "The role arn to use for GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}

output "name" {
  description = "The role name to use for GitHub Actions"
  value       = aws_iam_role.github_actions.name
}
