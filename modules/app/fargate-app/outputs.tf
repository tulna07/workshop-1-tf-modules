output "security_group_id" {
  description = "The security group id of the app"
  value       = aws_security_group.app.id
}

output "ecs_service_arn" {
  description = "The arn of the ecs service"
  value       = aws_ecs_service.main.id
}

output "ecs_cluster_name" {
  description = "The name of the ecs cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "The name of the ecs service"
  value       = aws_ecs_service.main.name
}

output"allow_to_communicate_with_dynamodb_role_arn" {
  description = "The role arn for allowing to communicate with dynamodb"
  value = aws_iam_role.allow_to_communicate_with_dynamodb.arn
}
