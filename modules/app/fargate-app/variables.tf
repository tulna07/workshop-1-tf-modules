variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ecs cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ecs service"
  type        = string
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

variable "container_definitions" {
  description = "The container definitions for the task"
  type        = string
}

variable "target_group_arn" {
  description = "The arn of the target group"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet ids of the app"
  type        = list(string)
}

variable "dynamodb_table_arn" {
  description = "The arn of the dynamodb table"
  type        = string
}

