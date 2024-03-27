locals {
  has_public_subnet = var.public_subnets != null && length(var.public_subnets) > 0
  all_ips           = "0.0.0.0/0"
}
