variable "bucket_regional_domain_name" {
  description = "The regional domain name of the bucket"
  type        = string
}

variable "alb_domain_name" {
  description = "The domain name of the alb"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the CloudFront distribution"
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
