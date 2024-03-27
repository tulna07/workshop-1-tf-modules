data "aws_caller_identity" "current" {
  count = var.enable_bucket_versioning ? 1 : 0
}


