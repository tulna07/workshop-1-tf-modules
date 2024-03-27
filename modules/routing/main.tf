module "route53" {
  source = "./route53"

  hosted_zone_name = var.hosted_zone_name
}
