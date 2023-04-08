variable "key_pair_name" {
  description = "The EC2 key pair name."
  type        = string
}

variable "db_username" {
  description = "The RDS instance master username."
  type        = string
}

variable "db_password" {
  description = "The RDS instance master password."
  type        = string
  sensitive   = true
}
