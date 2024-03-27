module "vpc" {
  source = "./vpc"

  name        = local.resource_name
  environment = var.environment

  vpc_cidr = var.vpc_cidr
  azs      = var.azs

  public_subnets        = var.public_subnets
  public_subnet_prefix  = var.public_subnet_prefix
  private_subnets       = var.private_subnets
  private_subnet_prefix = var.private_subnet_prefix
}
