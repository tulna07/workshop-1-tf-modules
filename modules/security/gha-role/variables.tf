variable "gh_oidc_provider_arn" {
  description = "The arn of GitHub openid connect provider"
  type        = string
}

variable "role_name" {
  description = "The name of the role"
  type        = string
}

variable "policy_arn" {
  description = "The policy arn for the role"
  type        = string
}

variable "github_org" {
  description = "The GitHub organization that the Github Actions role trusts"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository that the Github Actions role trusts"
  type        = string
}


