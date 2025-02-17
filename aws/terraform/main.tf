module "network" {
  source = "./modules/network"

  cidr_block = var.cidr_block
  vpc_additional_tags = var.vpc_additional_tags

  private_subnets = var.private_subnets
  private_subnets_additional_tags = var.private_subnets_additional_tags

  public_subnets = var.public_subnets
  public_subnets_additional_tags = var.public_subnets_additional_tags

}

module "lambda" {
  source            = "./modules/lambda"
  lambda_name       = var.lambda_function_name
  lambda_role_arn   = module.lambda.lambda_arn
  subnet_ids        = [module.network.private_subnet_id]
  security_group_id = module.lambda.lambda_sg
  vpc_id            = module.network.vpc_id
}

module "s3" {
  source               = "./modules/s3"
  s3_buckets           = var.s3_buckets
  lambda_function_arn  = module.lambda.lambda_function_arn
  function_name        = module.lambda.lambda_name
  lambda_role_arn      = module.lambda.lambda_exec_role_arn
}
