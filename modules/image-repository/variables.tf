variable "environment" {
  description = "The environment to which the repository delploys"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "force_delete" {
  description = "If true,  delete the repository even if it contains images"
  type        = bool
  default     = false
}


