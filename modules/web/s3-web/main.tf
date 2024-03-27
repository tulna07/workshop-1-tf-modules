resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.main.id
  policy = templatefile("${path.module}/allow-cloudfront-policy.tpl", {
    s3_bucket_arn  = aws_s3_bucket.main.arn,
    cloudfront_arn = var.cloudfront_arn
  })
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.enable_bucket_versioning ? 1 : 0
  bucket = aws_s3_bucket.main.id

  expected_bucket_owner = data.aws_caller_identity.current[0].account_id
  mfa                   = var.mfa_code

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}
