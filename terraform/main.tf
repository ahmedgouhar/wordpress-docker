module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
}
module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.private_subnets
  db_endpoint = module.rds.db_endpoint
  ecr_url     = module.ecr.repository_url
  alb_tg_arn  = module.alb.target_group_arn
}

module "rds" {
  source = "./modules/rds"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
}