module "vpc" {
  source = "../../modules/vpc"
}

module "web_app" {
  source = "../../modules/web_app"

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id

  instance_type = "t2.micro"
  key_pair_name = "example_key_pair"

}
