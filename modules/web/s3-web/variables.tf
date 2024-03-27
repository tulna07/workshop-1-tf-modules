variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "cloudfront_arn" {
  description = "The arn of cloudfront"
  type        = string
}

variable "enable_bucket_versioning" {
  description = "Enable bucket versioning to keep versions of the web"
  type        = bool
  default     = false
}

variable "mfa_code" {
  description = "The mfa code required if enabling bucket versioning"
  type        = string
  sensitive   = true
  default     = ""
}

variable "force_destroy" {
  description = "If true, remove all items in the bucket and then remove the bucket"
  type        = bool
  default     = false
}

