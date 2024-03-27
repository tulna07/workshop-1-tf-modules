resource "aws_iam_role" "github_actions" {
  name = var.role_name
  assume_role_policy = templatefile("${path.module}/gha-trust-policy.tpl", {
    gh_oidc_provider_arn = var.gh_oidc_provider_arn,
    github_org           = var.github_org,
    github_repo          = var.github_repo
  })
  managed_policy_arns = [var.policy_arn]
}

