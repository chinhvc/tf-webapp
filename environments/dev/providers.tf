provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "my-unique-bucket-name"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
  }
}