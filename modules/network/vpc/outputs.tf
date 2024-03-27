output "vpc_id" {
  description = "The id of the vpc"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "The arn of the vpc"
  value       = aws_vpc.main.arn
}

output "public_subnet_ids" {
  description = "The ids of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The ids of the private subnets"
  value       = aws_subnet.private[*].id
}

output "subnet_ids" {
  description = "The ids of the subnets"
  value       = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
}

output "public_route_table_id" {
  description = "The id of the public route table"
  value       = aws_route_table.public[0].id
}
