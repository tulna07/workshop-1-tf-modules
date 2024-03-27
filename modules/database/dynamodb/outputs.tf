output "table_arn" {
  description = "The arn of the dynamodb table"
  value       = aws_dynamodb_table.main.arn
}
