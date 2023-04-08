variable "aws_region" {
  description = "The AWS region to deploy the resources in."
  default     = "us-west-2"
}

variable "key_pair_name" {
  description = "The EC2 key pair name."
}

variable "db_username" {
  description = "The username for the PostgreSQL database."
}

variable "db_password" {
  description = "The password for the PostgreSQL database."
}