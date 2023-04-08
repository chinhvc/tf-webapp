locals {
  is_production = var.environment == "production"
  instance_type = local.is_production ? "t2.large" : "t2.micro"
}