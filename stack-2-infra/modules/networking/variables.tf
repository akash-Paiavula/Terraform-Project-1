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