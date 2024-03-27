output "name_servers" {
  description = "The name servers of the hosted zone"
  value       = aws_route53_zone.main.name_servers
}

output "zone_id" {
  description = "The id of the hosted zone"
  value       = aws_route53_zone.main.zone_id
}
