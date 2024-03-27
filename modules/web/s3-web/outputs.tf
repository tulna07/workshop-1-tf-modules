output "bucket_regional_domain_name" {
  description = "The regional domain name of the bucket"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_arn" {
  description = "The arn of bucket"
  value       = aws_s3_bucket.main.arn
}
