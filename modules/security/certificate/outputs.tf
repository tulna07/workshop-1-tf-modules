output "arn" {
  description = "The arn of the certificate"
  value       = aws_acm_certificate_validation.main.certificate_arn
}
