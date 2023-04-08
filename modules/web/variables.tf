variable "vpc_id" {
  description = "The VPC ID for the web app."
}

variable "public_subnet_id" {
  description = "The public subnet ID for the web app."
}

variable "instance_count" {
  description = "The number of Nginx web server instances to create"
  type        = number
  default     = 1
}

variable "instances" {
  description = "A map of instances with their names and types"
  type        = map(object({ instance_type = string }))
  default = {
    nginx1 = { instance_type = "t2.micro" }
  }
}

variable "key_pair_name" {
  description = "The EC2 key pair name."
}

variable "instance_type" {
  description = "The EC2 instance type for the web app."
  default     = "t2.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance."
  default     = 20
}

variable "db_engine" {
  description = "The RDS instance engine."
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The RDS instance engine version."
  default     = "13.3"
}

variable "db_instance_class" {
  description = "The RDS instance class."
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "The RDS instance database name."
  default     = "mydb"
}

variable "db_username" {
  description = "The RDS instance master username."
}

variable "db_password" {
  description = "The RDS instance master password."
}
