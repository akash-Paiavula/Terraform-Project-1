module "rds" {
    source = "./modules/storage"
    env_name = var.env_name
    private_subnet_ids = module.aws_vpc.private_subnet_ids
    vpc_id = module.aws_vpc.vpc_id
    vpc_cidr = module.aws_vpc.cidr_block
    rds_db_username = var.rds_db_username
    rds_db_parameter_name = var.rds_db_parameter_name
}