output "gh_oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.main.arn
  description = "The arn of Github openid connect provider"
}
