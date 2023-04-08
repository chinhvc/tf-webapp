terraform {
  required_version = "~> 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
