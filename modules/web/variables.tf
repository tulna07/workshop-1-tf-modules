variable "environment" {
  description = "The environment to which the web delploys"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "enable_bucket_versioning" {
  description = "Enable bucket versioning to keep versions of the web"
  type        = bool
  default     = false
}

variable "hosted_zone_id" {
  description = "The id of the Route53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The domain name of the website"
  type        = string
}

variable "alb_domain_name" {
  description = "The domain name of the alb"
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

variable "mfa_code" {
  description = "The mfa code required if enabling bucket versioning"
  type        = string
  sensitive   = true
  default     = ""
}


variable "gh_oidc_provider_arn" {
  description = "The arn of GitHub openid connect provider"
  type        = string
}

variable "s3_bucket_force_destroy" {
  description = "If true, remove all items in the bucket and then remove the bucket"
  type        = bool
  default     = false
}


