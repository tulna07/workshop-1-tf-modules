#----------------------------------------------------------------------
# TSL Certificate 
#----------------------------------------------------------------------
module "certificate" {
  source = "../security/certificate"

  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}

#----------------------------------------------------------------------
# Application Load Balancer
#----------------------------------------------------------------------
module "alb" {
  source = "./alb"

  name        = local.resource_name
  domain_name = var.domain_name

  vpc_id     = var.vpc_id
  subnet_ids = var.alb_subnet_ids

  hosted_zone_id  = var.hosted_zone_id
  certificate_arn = module.certificate.arn
}

resource "aws_vpc_security_group_ingress_rule" "allow_cloudfront" {
  security_group_id = module.alb.security_group_id

  prefix_list_id = data.aws_ec2_managed_prefix_list.cloudfront.id
  ip_protocol    = "tcp"
  from_port      = 443
  to_port        = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_from_alb" {
  security_group_id = module.alb.security_group_id
  cidr_ipv4         = local.all_ips
  ip_protocol       = local.any_protocol
}

#----------------------------------------------------------------------
# Auto Scaling Group
#----------------------------------------------------------------------
module "asg" {
  source = "./asg"

  ecs_cluster_name = module.fargate_app.ecs_cluster_name
  ecs_service_name = module.fargate_app.ecs_service_name

  max_capacity = var.max_capacity
  min_capacity = var.min_capacity
}

#----------------------------------------------------------------------
# Fargate App
#----------------------------------------------------------------------
module "fargate_app" {
  source = "./fargate-app"

  ecs_cluster_name = local.resource_name
  ecs_service_name = var.app_name

  vpc_id     = var.vpc_id
  subnet_ids = var.app_subnet_ids

  target_group_arn   = module.alb.target_group_arn
  dynamodb_table_arn = var.dynamodb_table_arn

  cpu           = var.cpu
  memory        = var.memory
  desired_count = var.desired_count

  container_definitions = var.container_definitions

  depends_on = [module.alb]
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb_to_app" {
  security_group_id = module.fargate_app.security_group_id

  referenced_security_group_id = module.alb.security_group_id
  ip_protocol                  = local.tcp_protocol
  from_port                    = var.app_port
  to_port                      = var.app_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_from_app" {
  security_group_id = module.fargate_app.security_group_id
  cidr_ipv4         = local.all_ips
  ip_protocol       = local.any_protocol
}

#----------------------------------------------------------------------
# GitHub Actions role for deploying app
#----------------------------------------------------------------------
module "gha_role" {
  source = "../security/gha-role"

  gh_oidc_provider_arn = var.gh_oidc_provider_arn

  role_name   = "gha-role-for-deploying-app"
  github_repo = var.github_repo
  github_org  = var.github_org

  policy_arn = aws_iam_policy.allow_deploy_app.arn
}

resource "aws_iam_policy" "allow_deploy_app" {
  name        = "AllowDeployApp"
  description = "IAM policy for deploying app to fargate"

  policy = templatefile("${path.module}/allow-deploy-app-policy.tpl", {
    ecs_execution_role_arn = data.aws_iam_role.ecs_task_execution.arn,
    ecs_task_role_arn      = module.fargate_app.allow_to_communicate_with_dynamodb_role_arn,
    ecs_service_arn        = module.fargate_app.ecs_service_arn,
    ecr_repository_arn     = var.ecr_repository_arn
  })
}

# #----------------------------------------------------------------------
# # s3 Gateway Endpoint
# #----------------------------------------------------------------------
resource "aws_vpc_endpoint" "s3_gateway_endpoint" {
  vpc_id = var.vpc_id

  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids   = [data.aws_route_table.app.route_table_id]

  tags = {
    Name        = "s3-gateway-endpoint"
    Environment = var.environment
  }
}

# #----------------------------------------------------------------------
# # DynamoDB Gateway Endpoint
# #----------------------------------------------------------------------
resource "aws_vpc_endpoint" "dynamodb_gateway_endpoint" {
  vpc_id = var.vpc_id

  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  route_table_ids   = [data.aws_route_table.app.route_table_id]

  tags = {
    Name        = "dynamodb-gateway-endpoint"
    Environment = var.environment
  }
}

# #----------------------------------------------------------------------
# # Security Group for Interface Endpoints allowing traffic from App
# #----------------------------------------------------------------------
resource "aws_security_group" "interface_endpoint" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_app" {
  security_group_id = aws_security_group.interface_endpoint.id

  referenced_security_group_id = module.fargate_app.security_group_id
  ip_protocol                  = local.tcp_protocol
  from_port                    = local.interface_endpoint_port
  to_port                      = local.interface_endpoint_port
}

# #----------------------------------------------------------------------
# # ecr api Interface Endpoint
# #----------------------------------------------------------------------
resource "aws_vpc_endpoint" "ecr_api_interface_endpoint" {
  vpc_id = var.vpc_id

  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  subnet_ids          = var.app_subnet_ids
  security_group_ids  = [aws_security_group.interface_endpoint.id]

  tags = {
    Name        = "ecr-api-interface-endpoint"
    Environment = var.environment
  }
}

# #----------------------------------------------------------------------
# # ecr dkr Interface Endpoint
# #----------------------------------------------------------------------
resource "aws_vpc_endpoint" "ecr_dkr_interface_endpoint" {
  vpc_id = var.vpc_id

  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  subnet_ids          = var.app_subnet_ids
  security_group_ids  = [aws_security_group.interface_endpoint.id]

  tags = {
    Name        = "ecr-dkr-interface-endpoint"
    Environment = var.environment
  }
}

