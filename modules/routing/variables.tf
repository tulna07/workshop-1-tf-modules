variable "environment" {
  description = "The environment to which the routing resources delploy"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "hosted_zone_name" {
  description = "The name of the Route53 hosted zone"
  type        = string
}
