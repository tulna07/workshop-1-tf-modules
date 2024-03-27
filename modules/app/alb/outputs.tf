output "target_group_arn" {
  description = "The arn of the alb targetgroup"
  value       = aws_lb_target_group.main.arn
}

output "security_group_id" {
  description = "The security group id of the alb"
  value       = aws_security_group.alb.id
}
