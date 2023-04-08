module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
}

module "web_app" {
  source               = "../../modules/web_app"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  key_pair_name        = var.key_pair_name
  db_username          = var.db_username
  db_password          = var.db_password
}
