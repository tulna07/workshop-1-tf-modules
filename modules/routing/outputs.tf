output "hosted_zone_name_servers" {
  description = "The name servers of the Route53 hosted zone"
  value       = module.route53.name_servers
}

output "hosted_zone_id" {
  description = "The id of the Route53 hosted zone"
  value       = module.route53.zone_id
}
