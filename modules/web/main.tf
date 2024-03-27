#----------------------------------------------------------------------
# TSL Certificate 
#----------------------------------------------------------------------
module "certificate" {
  source = "../security/certificate"

  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}

#----------------------------------------------------------------------
# CloudFront
#----------------------------------------------------------------------
module "cloudfront" {
  source = "./cloudfront"

  bucket_regional_domain_name = module.s3_web.bucket_regional_domain_name
  domain_name                 = var.domain_name
  alb_domain_name             = var.alb_domain_name
  hosted_zone_id              = var.hosted_zone_id
  certificate_arn             = module.certificate.arn
}

#----------------------------------------------------------------------
# S3 bucket for hosting ReactJS website
#----------------------------------------------------------------------
module "s3_web" {
  source = "./s3-web"

  bucket_name              = local.resource_name
  cloudfront_arn           = module.cloudfront.arn
  enable_bucket_versioning = var.enable_bucket_versioning
  mfa_code                 = var.mfa_code
  force_destroy            = var.s3_bucket_force_destroy
}

#----------------------------------------------------------------------
# GitHub Actions role for deploying web
#----------------------------------------------------------------------
module "gha_role" {
  source = "../security/gha-role"

  gh_oidc_provider_arn = var.gh_oidc_provider_arn

  role_name   = "gha-role-for-deploying-web"
  github_repo = var.github_repo
  github_org  = var.github_org

  policy_arn = aws_iam_policy.allow_deploy_web.arn
}

resource "aws_iam_policy" "allow_deploy_web" {
  name        = "AllowDeployWeb"
  description = "IAM policy for deploying static website to S3 bucket"

  policy = templatefile("${path.module}/allow-deploy-web-policy.tpl", {
    s3_bucket_arn = module.s3_web.bucket_arn
  })
}
