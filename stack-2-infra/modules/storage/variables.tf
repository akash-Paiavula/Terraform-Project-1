variable "env_name" {
    type = string
    description = "Envirnoment to deploy"
  
}

variable "private_subnet_ids" {
    type = list(string)
    description = "private subnet ids"
  
}

variable "vpc_id" {
    type = string
    description = "vpc_id"
  
}

variable "vpc_cidr" {
    type = string
    description = "VPC CIDR block"
  
}

variable "rds_db_username" {
  type = string
  description = "rds user name"
}

variable "rds_db_parameter_name" {
    type = string
    description = "SSM parameter name for RDS DB password"  
}