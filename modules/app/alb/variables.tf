variable "name" {
  description = "The name of the alb"
  type        = string
}

variable "domain_name" {
  description = "The domain name of the alb"
  type        = string
}

variable "hosted_zone_id" {
  description = "The id of the Route53 hosted zone"
  type        = string
}

variable "certificate_arn" {
  description = "The arn of the certificate"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet ids of the alb"
  type        = list(string)
}



