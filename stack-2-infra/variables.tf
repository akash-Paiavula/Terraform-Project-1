variable "cidr_block" {
    type = string
    description = "Envirnoment cidr"
  
}

variable "env_name" {
    type = string
    description = "Envirnoment env_name"
  
}

variable "public_subnet_count" {
    type = number
    description = "Number  of Public Subnets"
  
}
variable "private_subnet_count" {
    type = number
    description = "Number  of Private Subnets"
  
}

variable "rds_db_username" {
  type = string
  description = "rds user name"
}

variable "rds_db_parameter_name" {
    type = string
    description = "SSM parameter name for RDS DB password"  
}

