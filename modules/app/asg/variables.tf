variable "ecs_cluster_name" {
  description = "The name of the ecs cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ecs service"
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
