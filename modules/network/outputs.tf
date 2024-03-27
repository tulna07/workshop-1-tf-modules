output "vpc_id" {
  description = "The id of the vpc"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The arn of the vpc"
  value       = module.vpc.vpc_arn
}

output "public_subnet_ids" {
  description = "The ids of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The ids of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "subnet_ids" {
  description = "The ids of the subnets"
  value       = module.vpc.subnet_ids
}
