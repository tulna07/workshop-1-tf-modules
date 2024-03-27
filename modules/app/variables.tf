variable "environment" {
  description = "The environment to which the app delploys"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "hosted_zone_id" {
  description = "The id of the Route53 hosted zone"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "gh_oidc_provider_arn" {
  description = "The arn of GitHub openid connect provider"
  type        = string
}

variable "ecr_repository_arn" {
  description = "The arn of the ecr repository"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "The arn of the dynamodb table"
  type        = string
}

variable "domain_name" {
  description = "The domain name of the alb"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "max_capacity" {
  description = "The maximum number of tasks allowed in service"
  type        = number
  default     = 4
}

variable "min_capacity" {
  description = "The minimum number of tasks allowed in service"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "Number of cpu units used by the task"
  type        = string
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task definition"
  type        = number
}

variable "github_org" {
  description = "The GitHub organization that the Github Actions role trusts"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository that the Github Actions role trusts"
  type        = string
}

variable "container_definitions" {
  description = "The container definitions for the task"
  type        = string
}

variable "alb_subnet_ids" {
  description = "The subnet ids of the alb"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "The subnet ids of the app"
  type        = list(string)
}

variable "app_port" {
  description = "The port of the app"
  type        = number
}
