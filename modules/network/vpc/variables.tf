variable "name" {
  description = "The name of the vpc"
  type        = string
}

variable "environment" {
  description = "The environment to which the vpc delploys"
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr block of the vpc"
  type        = string
}

variable "azs" {
  description = "The choosen azs to allocate resources in the vpc"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "The cidr blocks for the public subnets"
  type = list(object({
    cidr = string,
    tier = optional(string)
  }))
  default = []
}

variable "public_subnet_prefix" {
  description = "Prefix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "private_subnets" {
  description = "The cidr blocks for the private subnets"
  type = list(object({
    cidr = string,
    tier = optional(string)
  }))
  default = []
}

variable "private_subnet_prefix" {
  description = "Prefix to append to private subnets name"
  type        = string
  default     = "private"
}
